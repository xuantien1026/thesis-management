# frozen_string_literal: true

class BaseActionPolicy
  def allowed?
    @errors = []
    self.class.conditions.each do |condition|
      @errors << condition.error unless send(condition.name)
    end
    @errors.empty?
  end

  attr_reader :errors

  def self.condition(name, on_error: nil)
    conditions << OpenStruct.new(name: name, error: on_error)
  end

  def self.conditions
    instance_variable_set(:@conditions, []) unless instance_variable_defined? :@conditions
    instance_variable_get(:@conditions)
  end
end
