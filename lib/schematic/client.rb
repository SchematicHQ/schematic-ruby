# frozen_string_literal: true

module Schematic
  class Client
    # @param request_options [Hash]
    # @param _params [Hash]
    # @option request_options [String] :base_url
    # @option request_options [Hash{String => Object}] :additional_headers
    # @option request_options [Hash{String => Object}] :additional_query_parameters
    # @option request_options [Hash{String => Object}] :additional_body_parameters
    # @option request_options [Integer] :timeout_in_seconds
    #
    # @example
    #   client.get_credit_ledger
    #
    # @return [untyped]
    def get_credit_ledger(request_options: {}, **_params)
      request = Schematic::Internal::JSON::Request.new(
        base_url: request_options[:base_url],
        method: "GET",
        path: "billing/credits/ledger",
        request_options: request_options
      )
      begin
        response = @client.send(request)
      rescue Net::HTTPRequestTimeout
        raise Schematic::Errors::TimeoutError
      end
      code = response.code.to_i
      return if code.between?(200, 299)

      error_class = Schematic::Errors::ResponseError.subclass_for_code(code)
      raise error_class.new(response.body, code: code)
    end

    # @param api_key [String]
    # @param base_url [String, nil]
    # @param max_retries [Integer]
    #
    # @return [void]
    def initialize(api_key:, base_url: nil, max_retries: 2)
      @raw_client = Schematic::Internal::Http::RawClient.new(
        base_url: base_url || Schematic::Environment::DEFAULT,
        headers: {
          "User-Agent" => "schematichq/1.4.15",
          "X-Fern-Language" => "Ruby",
          "X-Schematic-Api-Key" => api_key.to_s
        },
        max_retries: max_retries
      )
    end

    # @return [Schematic::Accounts::Client]
    def accounts
      @accounts ||= Schematic::Accounts::Client.new(client: @raw_client)
    end

    # @return [Schematic::Billing::Client]
    def billing
      @billing ||= Schematic::Billing::Client.new(client: @raw_client)
    end

    # @return [Schematic::Credits::Client]
    def credits
      @credits ||= Schematic::Credits::Client.new(client: @raw_client)
    end

    # @return [Schematic::Catalogs::Client]
    def catalogs
      @catalogs ||= Schematic::Catalogs::Client.new(client: @raw_client)
    end

    # @return [Schematic::Checkout::Client]
    def checkout
      @checkout ||= Schematic::Checkout::Client.new(client: @raw_client)
    end

    # @return [Schematic::Companies::Client]
    def companies
      @companies ||= Schematic::Companies::Client.new(client: @raw_client)
    end

    # @return [Schematic::Entitlements::Client]
    def entitlements
      @entitlements ||= Schematic::Entitlements::Client.new(client: @raw_client)
    end

    # @return [Schematic::Plans::Client]
    def plans
      @plans ||= Schematic::Plans::Client.new(client: @raw_client)
    end

    # @return [Schematic::Components::Client]
    def components
      @components ||= Schematic::Components::Client.new(client: @raw_client)
    end

    # @return [Schematic::Planbundle::Client]
    def planbundle
      @planbundle ||= Schematic::Planbundle::Client.new(client: @raw_client)
    end

    # @return [Schematic::Dataexports::Client]
    def dataexports
      @dataexports ||= Schematic::Dataexports::Client.new(client: @raw_client)
    end

    # @return [Schematic::Events::Client]
    def events
      @events ||= Schematic::Events::Client.new(client: @raw_client)
    end

    # @return [Schematic::Features::Client]
    def features
      @features ||= Schematic::Features::Client.new(client: @raw_client)
    end

    # @return [Schematic::Insights::Client]
    def insights
      @insights ||= Schematic::Insights::Client.new(client: @raw_client)
    end

    # @return [Schematic::Integrationsapi::Client]
    def integrationsapi
      @integrationsapi ||= Schematic::Integrationsapi::Client.new(client: @raw_client)
    end

    # @return [Schematic::Licenses::Client]
    def licenses
      @licenses ||= Schematic::Licenses::Client.new(client: @raw_client)
    end

    # @return [Schematic::Plangroups::Client]
    def plangroups
      @plangroups ||= Schematic::Plangroups::Client.new(client: @raw_client)
    end

    # @return [Schematic::Planmigrations::Client]
    def planmigrations
      @planmigrations ||= Schematic::Planmigrations::Client.new(client: @raw_client)
    end

    # @return [Schematic::Componentspublic::Client]
    def componentspublic
      @componentspublic ||= Schematic::Componentspublic::Client.new(client: @raw_client)
    end

    # @return [Schematic::Scheduledcheckout::Client]
    def scheduledcheckout
      @scheduledcheckout ||= Schematic::Scheduledcheckout::Client.new(client: @raw_client)
    end

    # @return [Schematic::Accesstokens::Client]
    def accesstokens
      @accesstokens ||= Schematic::Accesstokens::Client.new(client: @raw_client)
    end

    # @return [Schematic::Webhooks::Client]
    def webhooks
      @webhooks ||= Schematic::Webhooks::Client.new(client: @raw_client)
    end
  end
end
