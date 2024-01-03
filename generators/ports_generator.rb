# frozen_string_literal: true

class PortsGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Company.name,
      CAPTION: Faker::Lorem.sentence,
      DESCRIPTION: Faker::Lorem.paragraph,
      TYPE: "#{Faker::Alphanumeric.alpha[0, 5]} Port"
    }
  end
end
