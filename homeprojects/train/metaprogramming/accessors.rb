module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) { |value| instance_variable_set(var_name, value) }
    end
  end

  def attribute_history
    values = test.instance_variables.map { |var| test.instance_variable_get(var) }
    puts values.inspect
  end

  def strong_attr_accessor(name, attr_class)
    name.each do |attr_name|
      var_name = "@#{attr_name}".to_sym
      define_method(attr_name) { instance_variable_get(var_name) }
      define_method("#{attr_name}=".to_sym).each do |value|
        raise 'The type of the value is incorrect' unless attr_class == value

        instance_variable_set(var_name, value)
      end
    end
  end
end
