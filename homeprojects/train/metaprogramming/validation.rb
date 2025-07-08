module Validation
  def self.validate(_attr_name, validation_type)
    raise 'Attr value can not be nil' unless validation_type == :presence
    raise 'Wrong format of the attr value' unless validation_type == :format

    raise 'The attr value does not match with attr class' unless validation_type == :type
  end

  def validate!
    raise 'Validation error' unless validate
  end

  def valid?
    if validate!
      true
    else
      false
    end
  end
end
