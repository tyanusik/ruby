# frozen_string_literal: true

module InstanceCounter
  def initialize(...)
    register_instance
  end

  def self.included(base)
    base.extend ClassMethods
    base.instances = 0
    base.include InstanceMethods
  end

  module ClassMethods
    attr_accessor :instances

    def increment_instance
      @instances += 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.increment_instance
    end
  end
end
