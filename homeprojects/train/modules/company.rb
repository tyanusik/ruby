module Company
  attr_accessor :company

  def company_name=(name)
    raise "Company name can't be nil" if name.nil?

    @company = name
  end
end
