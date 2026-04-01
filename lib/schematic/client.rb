# frozen_string_literal: true

module Schematic
  class Client
    # @param base_url [String, nil]
    # @param api_key [String]
    #
    # @return [void]
    def initialize(api_key:, base_url: nil)
      @raw_client = Schematic::Internal::Http::RawClient.new(
        base_url: base_url || Schematic::Environment::DEFAULT,
        headers: {
          "User-Agent" => "schematichq/0.1.0",
          "X-Fern-Language" => "Ruby",
          "X-Schematic-Api-Key" => api_key.to_s
        }
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

    # @return [Schematic::Planbundle::Client]
    def planbundle
      @planbundle ||= Schematic::Planbundle::Client.new(client: @raw_client)
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
