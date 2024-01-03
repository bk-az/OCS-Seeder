# frozen_string_literal: true

class SoundsGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Company.name,
      MANUFACTURER: Faker::Device.manufacturer,
      DESCRIPTION: Faker::Lorem.paragraph
    }
  end
end
