# frozen_string_literal: true

class ControllersGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      MANUFACTURER: Faker::Device.manufacturer,
      NAME: Faker::Company.name,
      CAPTION: Faker::Lorem.sentence,
      DESCRIPTION: Faker::Lorem.paragraph,
      VERSION: "#{rand(0..10)}.#{rand(0..999)}.#{rand(0...100_000)}",
      TYPE: "#{Faker::Alphanumeric.alpha[0, 3]} Controller"
    }
  end
end
