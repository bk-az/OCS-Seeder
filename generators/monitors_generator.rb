# frozen_string_literal: true

class MonitorsGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      MANUFACTURER: Faker::Device.manufacturer,
      CAPTION: Faker::Lorem.sentence,
      DESCRIPTION: Faker::Lorem.paragraph,
      TYPE: "#{Faker::Alphanumeric.alpha[0, 3]} Monitor",
      SERIAL: Faker::Alphanumeric.alphanumeric.upcase[0, rand(5..25)]
    }
  end
end
