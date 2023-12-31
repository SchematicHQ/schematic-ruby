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
  class CreateOrUpdateConditionRequestBody
    # Optionally provide a trait ID to compare a metric or trait value against instead of a value
    attr_accessor :comparison_trait_id

    attr_accessor :condition_type

    # Name of track event type used to measure this condition
    attr_accessor :event_subtype

    attr_accessor :id

    # Period of time over which to measure the track event metric
    attr_accessor :metric_period

    # Value to compare the track event metric against
    attr_accessor :metric_value

    attr_accessor :operator

    # List of resource IDs (companise, users, or plans) targeted by this condition
    attr_accessor :resource_ids

    # ID of trait to use to measure this condition
    attr_accessor :trait_id

    # Value to compare the trait value against
    attr_accessor :trait_value

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'comparison_trait_id' => :'comparison_trait_id',
        :'condition_type' => :'condition_type',
        :'event_subtype' => :'event_subtype',
        :'id' => :'id',
        :'metric_period' => :'metric_period',
        :'metric_value' => :'metric_value',
        :'operator' => :'operator',
        :'resource_ids' => :'resource_ids',
        :'trait_id' => :'trait_id',
        :'trait_value' => :'trait_value'
      }
    end

    # Returns all the JSON keys this model knows about
    def self.acceptable_attributes
      attribute_map.values
    end

    # Attribute type mapping.
    def self.openapi_types
      {
        :'comparison_trait_id' => :'String',
        :'condition_type' => :'String',
        :'event_subtype' => :'String',
        :'id' => :'String',
        :'metric_period' => :'String',
        :'metric_value' => :'Integer',
        :'operator' => :'String',
        :'resource_ids' => :'Array<String>',
        :'trait_id' => :'String',
        :'trait_value' => :'String'
      }
    end

    # List of attributes with nullable: true
    def self.openapi_nullable
      Set.new([
        :'comparison_trait_id',
        :'event_subtype',
        :'id',
        :'metric_period',
        :'trait_id',
        :'trait_value'
      ])
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      if (!attributes.is_a?(Hash))
        fail ArgumentError, "The input argument (attributes) must be a hash in `Schematic::CreateOrUpdateConditionRequestBody` initialize method"
      end

      # check to see if the attribute exists and convert string to symbol for hash key
      attributes = attributes.each_with_object({}) { |(k, v), h|
        if (!self.class.attribute_map.key?(k.to_sym))
          fail ArgumentError, "`#{k}` is not a valid attribute in `Schematic::CreateOrUpdateConditionRequestBody`. Please check the name to make sure it's valid. List of attributes: " + self.class.attribute_map.keys.inspect
        end
        h[k.to_sym] = v
      }

      if attributes.key?(:'comparison_trait_id')
        self.comparison_trait_id = attributes[:'comparison_trait_id']
      end

      if attributes.key?(:'condition_type')
        self.condition_type = attributes[:'condition_type']
      end

      if attributes.key?(:'event_subtype')
        self.event_subtype = attributes[:'event_subtype']
      end

      if attributes.key?(:'id')
        self.id = attributes[:'id']
      end

      if attributes.key?(:'metric_period')
        self.metric_period = attributes[:'metric_period']
      end

      if attributes.key?(:'metric_value')
        self.metric_value = attributes[:'metric_value']
      end

      if attributes.key?(:'operator')
        self.operator = attributes[:'operator']
      end

      if attributes.key?(:'resource_ids')
        if (value = attributes[:'resource_ids']).is_a?(Array)
          self.resource_ids = value
        end
      end

      if attributes.key?(:'trait_id')
        self.trait_id = attributes[:'trait_id']
      end

      if attributes.key?(:'trait_value')
        self.trait_value = attributes[:'trait_value']
      end
    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properties with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @condition_type.nil?
        invalid_properties.push('invalid value for "condition_type", condition_type cannot be nil.')
      end

      if @metric_value.nil?
        invalid_properties.push('invalid value for "metric_value", metric_value cannot be nil.')
      end

      if @operator.nil?
        invalid_properties.push('invalid value for "operator", operator cannot be nil.')
      end

      if @resource_ids.nil?
        invalid_properties.push('invalid value for "resource_ids", resource_ids cannot be nil.')
      end

      invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      return false if @condition_type.nil?
      return false if @metric_value.nil?
      return false if @operator.nil?
      return false if @resource_ids.nil?
      true
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          comparison_trait_id == o.comparison_trait_id &&
          condition_type == o.condition_type &&
          event_subtype == o.event_subtype &&
          id == o.id &&
          metric_period == o.metric_period &&
          metric_value == o.metric_value &&
          operator == o.operator &&
          resource_ids == o.resource_ids &&
          trait_id == o.trait_id &&
          trait_value == o.trait_value
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Integer] Hash code
    def hash
      [comparison_trait_id, condition_type, event_subtype, id, metric_period, metric_value, operator, resource_ids, trait_id, trait_value].hash
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
