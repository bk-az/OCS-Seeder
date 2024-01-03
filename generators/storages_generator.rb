# frozen_string_literal: true

class StoragesGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      MANUFACTURER: Faker::Device.manufacturer,
      NAME: Faker::Company.name,
      MODEL: Faker::Device.model_name,
      DESCRIPTION: Faker::Lorem.paragraph,
      TYPE: "#{Faker::Alphanumeric.alpha[0, 3]} STORAGE",
      DISKSIZE: 2**rand(10..16),
      SERIALNUMBER: Faker::Alphanumeric.alphanumeric.upcase[0, rand(5..25)],
      FIRMWARE: Faker::App.name
    }
  end
end
