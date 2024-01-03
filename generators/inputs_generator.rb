# frozen_string_literal: true

class InputsGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      TYPE: "#{Faker::Alphanumeric.alpha[0, 3]} INPUT",
      MANUFACTURER: Faker::Device.manufacturer,
      CAPTION: Faker::Lorem.sentence,
      DESCRIPTION: Faker::Lorem.paragraph,
      INTERFACE: "Port_#000#{rand(1..9)}.Hub_#000#{rand(1..9)}",
      POINTTYPE: ''
    }
  end
end
