# frozen_string_literal: true

class BiosGenerator < Generator
  def manufacturer
    @manufacturer ||= args.dig(:hardware, :WINCOMPANY) || Faker::Device.manufacturer
  end

  def model
    @model ||= "#{manufacturer} #{rand(10..100)}"
  end

  def ssn
    @ssn ||= "#{Faker::Number.hexadecimal.upcase}#{Time.now.to_i}#{Time.now.nsec}"
  end

  def b_version
    @b_version ||= "#{rand(0..100)}.#{Time.now.to_i}.#{Time.now.nsec}"
  end

  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      SMANUFACTURER: manufacturer,
      SMODEL: model,
      SSN: ssn,
      TYPE: %w[Notebook Other].sample,
      BMANUFACTURER: manufacturer,
      BVERSION: b_version,
      BDATE: generate_random_date(DateTime.now - 3650),
      ASSETTAG: Faker::Alphanumeric.alphanumeric
    }
  end
end
