=begin
#Schematic API

#Schematic API

The version of the OpenAPI document: 0.1

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.6.0

=end

require 'cgi'

module Schematic
  class CompaniesApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end
    # Create company
    # @param upsert_company_request_body [UpsertCompanyRequestBody] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [CreateCompanyResponse]
    def create_company(upsert_company_request_body, opts = {})
      data, _status_code, _headers = create_company_with_http_info(upsert_company_request_body, opts)
      data
    end

    # Create company
    # @param upsert_company_request_body [UpsertCompanyRequestBody] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [Array<(CreateCompanyResponse, Integer, Hash)>] CreateCompanyResponse data, response status code and response headers
    def create_company_with_http_info(upsert_company_request_body, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.create_company ...'
      end
      # verify the required parameter 'upsert_company_request_body' is set
      if @api_client.config.client_side_validation && upsert_company_request_body.nil?
        fail ArgumentError, "Missing the required parameter 'upsert_company_request_body' when calling CompaniesApi.create_company"
      end
      # resource path
      local_var_path = '/companies'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      content_type = @api_client.select_header_content_type(['application/json'])
      if !content_type.nil?
          header_params['Content-Type'] = content_type
      end
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body] || @api_client.object_to_http_body(upsert_company_request_body)

      # return_type
      return_type = opts[:debug_return_type] || 'CreateCompanyResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.create_company",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#create_company\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Create company membership
    # @param get_or_create_company_membership_request_body [GetOrCreateCompanyMembershipRequestBody] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [CreateCompanyMembershipResponse]
    def create_company_membership(get_or_create_company_membership_request_body, opts = {})
      data, _status_code, _headers = create_company_membership_with_http_info(get_or_create_company_membership_request_body, opts)
      data
    end

    # Create company membership
    # @param get_or_create_company_membership_request_body [GetOrCreateCompanyMembershipRequestBody] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [Array<(CreateCompanyMembershipResponse, Integer, Hash)>] CreateCompanyMembershipResponse data, response status code and response headers
    def create_company_membership_with_http_info(get_or_create_company_membership_request_body, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.create_company_membership ...'
      end
      # verify the required parameter 'get_or_create_company_membership_request_body' is set
      if @api_client.config.client_side_validation && get_or_create_company_membership_request_body.nil?
        fail ArgumentError, "Missing the required parameter 'get_or_create_company_membership_request_body' when calling CompaniesApi.create_company_membership"
      end
      # resource path
      local_var_path = '/company-memberships'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      content_type = @api_client.select_header_content_type(['application/json'])
      if !content_type.nil?
          header_params['Content-Type'] = content_type
      end
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body] || @api_client.object_to_http_body(get_or_create_company_membership_request_body)

      # return_type
      return_type = opts[:debug_return_type] || 'CreateCompanyMembershipResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.create_company_membership",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#create_company_membership\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Create user
    # @param upsert_user_request_body [UpsertUserRequestBody] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [CreateUserResponse]
    def create_user(upsert_user_request_body, opts = {})
      data, _status_code, _headers = create_user_with_http_info(upsert_user_request_body, opts)
      data
    end

    # Create user
    # @param upsert_user_request_body [UpsertUserRequestBody] 
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [Array<(CreateUserResponse, Integer, Hash)>] CreateUserResponse data, response status code and response headers
    def create_user_with_http_info(upsert_user_request_body, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.create_user ...'
      end
      # verify the required parameter 'upsert_user_request_body' is set
      if @api_client.config.client_side_validation && upsert_user_request_body.nil?
        fail ArgumentError, "Missing the required parameter 'upsert_user_request_body' when calling CompaniesApi.create_user"
      end
      # resource path
      local_var_path = '/users'

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      # HTTP header 'Content-Type'
      content_type = @api_client.select_header_content_type(['application/json'])
      if !content_type.nil?
          header_params['Content-Type'] = content_type
      end
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body] || @api_client.object_to_http_body(upsert_user_request_body)

      # return_type
      return_type = opts[:debug_return_type] || 'CreateUserResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.create_user",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:POST, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#create_user\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Delete company membership
    # @param company_membership_id [String] company_membership_id
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [DeleteCompanyMembershipResponse]
    def delete_company_membership(company_membership_id, opts = {})
      data, _status_code, _headers = delete_company_membership_with_http_info(company_membership_id, opts)
      data
    end

    # Delete company membership
    # @param company_membership_id [String] company_membership_id
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [Array<(DeleteCompanyMembershipResponse, Integer, Hash)>] DeleteCompanyMembershipResponse data, response status code and response headers
    def delete_company_membership_with_http_info(company_membership_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.delete_company_membership ...'
      end
      # verify the required parameter 'company_membership_id' is set
      if @api_client.config.client_side_validation && company_membership_id.nil?
        fail ArgumentError, "Missing the required parameter 'company_membership_id' when calling CompaniesApi.delete_company_membership"
      end
      # resource path
      local_var_path = '/company-memberships/{company_membership_id}'.sub('{' + 'company_membership_id' + '}', CGI.escape(company_membership_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'DeleteCompanyMembershipResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.delete_company_membership",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:DELETE, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#delete_company_membership\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get company
    # @param company_id [String] company_id
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [GetCompanyResponse]
    def get_company(company_id, opts = {})
      data, _status_code, _headers = get_company_with_http_info(company_id, opts)
      data
    end

    # Get company
    # @param company_id [String] company_id
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [Array<(GetCompanyResponse, Integer, Hash)>] GetCompanyResponse data, response status code and response headers
    def get_company_with_http_info(company_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.get_company ...'
      end
      # verify the required parameter 'company_id' is set
      if @api_client.config.client_side_validation && company_id.nil?
        fail ArgumentError, "Missing the required parameter 'company_id' when calling CompaniesApi.get_company"
      end
      # resource path
      local_var_path = '/companies/{company_id}'.sub('{' + 'company_id' + '}', CGI.escape(company_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'GetCompanyResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.get_company",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#get_company\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # Get user
    # @param user_id [String] user_id
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [GetUserResponse]
    def get_user(user_id, opts = {})
      data, _status_code, _headers = get_user_with_http_info(user_id, opts)
      data
    end

    # Get user
    # @param user_id [String] user_id
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @return [Array<(GetUserResponse, Integer, Hash)>] GetUserResponse data, response status code and response headers
    def get_user_with_http_info(user_id, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.get_user ...'
      end
      # verify the required parameter 'user_id' is set
      if @api_client.config.client_side_validation && user_id.nil?
        fail ArgumentError, "Missing the required parameter 'user_id' when calling CompaniesApi.get_user"
      end
      # resource path
      local_var_path = '/users/{user_id}'.sub('{' + 'user_id' + '}', CGI.escape(user_id.to_s))

      # query parameters
      query_params = opts[:query_params] || {}

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'GetUserResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.get_user",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#get_user\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # List companies
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @option opts [Array<Integer>] :ids 
    # @option opts [Integer] :limit Page limit (default 100)
    # @option opts [Integer] :offset Page offset (default 0)
    # @option opts [String] :order Order by column
    # @option opts [String] :dir Order direction
    # @return [ListCompaniesResponse]
    def list_companies(opts = {})
      data, _status_code, _headers = list_companies_with_http_info(opts)
      data
    end

    # List companies
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @option opts [Array<Integer>] :ids 
    # @option opts [Integer] :limit Page limit (default 100)
    # @option opts [Integer] :offset Page offset (default 0)
    # @option opts [String] :order Order by column
    # @option opts [String] :dir Order direction
    # @return [Array<(ListCompaniesResponse, Integer, Hash)>] ListCompaniesResponse data, response status code and response headers
    def list_companies_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.list_companies ...'
      end
      # resource path
      local_var_path = '/companies'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'ids'] = @api_client.build_collection_param(opts[:'ids'], :multi) if !opts[:'ids'].nil?
      query_params[:'limit'] = opts[:'limit'] if !opts[:'limit'].nil?
      query_params[:'offset'] = opts[:'offset'] if !opts[:'offset'].nil?
      query_params[:'order'] = opts[:'order'] if !opts[:'order'].nil?
      query_params[:'dir'] = opts[:'dir'] if !opts[:'dir'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'ListCompaniesResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.list_companies",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#list_companies\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # List company memberships
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @option opts [String] :company_id 
    # @option opts [String] :user_id 
    # @option opts [Integer] :limit Page limit (default 100)
    # @option opts [Integer] :offset Page offset (default 0)
    # @option opts [String] :order Order by column
    # @option opts [String] :dir Order direction
    # @return [ListCompanyMembershipsResponse]
    def list_company_memberships(opts = {})
      data, _status_code, _headers = list_company_memberships_with_http_info(opts)
      data
    end

    # List company memberships
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @option opts [String] :company_id 
    # @option opts [String] :user_id 
    # @option opts [Integer] :limit Page limit (default 100)
    # @option opts [Integer] :offset Page offset (default 0)
    # @option opts [String] :order Order by column
    # @option opts [String] :dir Order direction
    # @return [Array<(ListCompanyMembershipsResponse, Integer, Hash)>] ListCompanyMembershipsResponse data, response status code and response headers
    def list_company_memberships_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.list_company_memberships ...'
      end
      # resource path
      local_var_path = '/company-memberships'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'company_id'] = opts[:'company_id'] if !opts[:'company_id'].nil?
      query_params[:'user_id'] = opts[:'user_id'] if !opts[:'user_id'].nil?
      query_params[:'limit'] = opts[:'limit'] if !opts[:'limit'].nil?
      query_params[:'offset'] = opts[:'offset'] if !opts[:'offset'].nil?
      query_params[:'order'] = opts[:'order'] if !opts[:'order'].nil?
      query_params[:'dir'] = opts[:'dir'] if !opts[:'dir'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'ListCompanyMembershipsResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.list_company_memberships",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#list_company_memberships\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # List users
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @option opts [Array<Integer>] :ids 
    # @option opts [Integer] :limit Page limit (default 100)
    # @option opts [Integer] :offset Page offset (default 0)
    # @option opts [String] :order Order by column
    # @option opts [String] :dir Order direction
    # @return [ListUsersResponse]
    def list_users(opts = {})
      data, _status_code, _headers = list_users_with_http_info(opts)
      data
    end

    # List users
    # @param [Hash] opts the optional parameters
    # @option opts [String] :x_schematic_environment_id If the request is made using an API key that is not environment-scoped, specify the environment using this header
    # @option opts [Array<Integer>] :ids 
    # @option opts [Integer] :limit Page limit (default 100)
    # @option opts [Integer] :offset Page offset (default 0)
    # @option opts [String] :order Order by column
    # @option opts [String] :dir Order direction
    # @return [Array<(ListUsersResponse, Integer, Hash)>] ListUsersResponse data, response status code and response headers
    def list_users_with_http_info(opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug 'Calling API: CompaniesApi.list_users ...'
      end
      # resource path
      local_var_path = '/users'

      # query parameters
      query_params = opts[:query_params] || {}
      query_params[:'ids'] = @api_client.build_collection_param(opts[:'ids'], :multi) if !opts[:'ids'].nil?
      query_params[:'limit'] = opts[:'limit'] if !opts[:'limit'].nil?
      query_params[:'offset'] = opts[:'offset'] if !opts[:'offset'].nil?
      query_params[:'order'] = opts[:'order'] if !opts[:'order'].nil?
      query_params[:'dir'] = opts[:'dir'] if !opts[:'dir'].nil?

      # header parameters
      header_params = opts[:header_params] || {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'X-Schematic-Environment-Id'] = opts[:'x_schematic_environment_id'] if !opts[:'x_schematic_environment_id'].nil?

      # form parameters
      form_params = opts[:form_params] || {}

      # http body (model)
      post_body = opts[:debug_body]

      # return_type
      return_type = opts[:debug_return_type] || 'ListUsersResponse'

      # auth_names
      auth_names = opts[:debug_auth_names] || ['ApiKeyAuth']

      new_options = opts.merge(
        :operation => :"CompaniesApi.list_users",
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names,
        :return_type => return_type
      )

      data, status_code, headers = @api_client.call_api(:GET, local_var_path, new_options)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: CompaniesApi#list_users\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
