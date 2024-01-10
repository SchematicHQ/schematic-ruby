=begin
#Schematic API

#Schematic API

The version of the OpenAPI document: 0.1

Generated by: https://openapi-generator.tech
OpenAPI Generator version: 6.6.0

=end

require 'date'
require 'time'

module Schematic
  # The returned resource
  class ApiKeyRequestResponseData
    attr_accessor :api_key_id

    attr_accessor :ended_at

    attr_accessor :environment_id

    attr_accessor :id

    attr_accessor :method

    attr_accessor :req_body

    attr_accessor :resp_body

    attr_accessor :resp_code

    attr_accessor :started_at

    attr_accessor :url

    attr_accessor :user_agent

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'api_key_id' => :'api_key_id',
        :'ended_at' => :'ended_at',
        :'environment_id' => :'environment_id',
        :'id' => :'id',
        :'method' => :'method',
        :'req_body' => :'req_body',
        :'resp_body' => :'resp_body',
        :'resp_code' => :'resp_code',
        :'started_at' => :'started_at',
        :'url' => :'url',
        :'user_agent' => :'user_agent'
      }
    end

    # Returns all the JSON keys this model knows about
    def self.acceptable_attributes
      attribute_map.values
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'api_key_id' => :'String',
        :'ended_at' => :'Time',
        :'environment_id' => :'String',
        :'id' => :'String',
        :'method' => :'String',
        :'req_body' => :'String',
        :'resp_body' => :'String',
        :'resp_code' => :'Integer',
        :'started_at' => :'Time',
        :'url' => :'String',
        :'user_agent' => :'String'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'ended_at',
        :'environment_id',
        :'req_body',
        :'resp_body',
        :'resp_code',
        :'user_agent'
      ])
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `Schematic::ApiKeyRequestResponseData` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `Schematic::ApiKeyRequestResponseData`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'api_key_id')
        self.api_key_id = attributes[:'api_key_id']
      end

      if attributes.key?(:'ended_at')
        self.ended_at = attributes[:'ended_at']
      end

      if attributes.key?(:'environment_id')
        self.environment_id = attributes[:'environment_id']
      end

      if attributes.key?(:'id')
        self.id = attributes[:'id']
      end

      if attributes.key?(:'method')
        self.method = attributes[:'method']
      end

      if attributes.key?(:'req_body')
        self.req_body = attributes[:'req_body']
      end

      if attributes.key?(:'resp_body')
        self.resp_body = attributes[:'resp_body']
      end

      if attributes.key?(:'resp_code')
        self.resp_code = attributes[:'resp_code']
      end

      if attributes.key?(:'started_at')
        self.started_at = attributes[:'started_at']
      end

      if attributes.key?(:'url')
        self.url = attributes[:'url']
      end

      if attributes.key?(:'user_agent')
        self.user_agent = attributes[:'user_agent']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @api_key_id.nil?
        invalid_properties.push('invalid value for "api_key_id", api_key_id cannot be nil.')
      end

      if @id.nil?
        invalid_properties.push('invalid value for "id", id cannot be nil.')
      end

      if @method.nil?
        invalid_properties.push('invalid value for "method", method cannot be nil.')
      end

      if @started_at.nil?
        invalid_properties.push('invalid value for "started_at", started_at cannot be nil.')
      end

      if @url.nil?
        invalid_properties.push('invalid value for "url", url cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @api_key_id.nil?
      return false if @id.nil?
      return false if @method.nil?
      return false if @started_at.nil?
      return false if @url.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          api_key_id == o.api_key_id &&
          ended_at == o.ended_at &&
          environment_id == o.environment_id &&
          id == o.id &&
          method == o.method &&
          req_body == o.req_body &&
          resp_body == o.resp_body &&
          resp_code == o.resp_code &&
          started_at == o.started_at &&
          url == o.url &&
          user_agent == o.user_agent
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [api_key_id, ended_at, environment_id, id, method, req_body, resp_body, resp_code, started_at, url, user_agent].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def self.build_from_hash(attributes)
      new.build_from_hash(attributes)
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      attributes = attributes.transform_keys(&:to_sym)
      self.class.openapi_types.each_pair do |key, type|
        if attributes[self.class.attribute_map[key]].nil? && self.class.openapi_nullable.include?(key)
          self.send("#{key}=", nil)
        elsif type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map { |v| _deserialize($1, v) })
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :Time
        Time.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :Boolean
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        # models (e.g. Pet) or oneOf
        klass = Schematic.const_get(type)
        klass.respond_to?(:openapi_one_of) ? klass.build(value) : klass.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        if value.nil?
          is_nullable = self.class.openapi_nullable.include?(attr)
          next if !is_nullable || (is_nullable && !instance_variable_defined?(:"@#{attr}"))
        end

        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map { |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end

end
