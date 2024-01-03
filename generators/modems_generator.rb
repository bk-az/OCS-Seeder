# frozen_string_literal: true

class ModemsGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Company.name,
      MODEL: Faker::Device.model_name,
      DESCRIPTION: Faker::Lorem.paragraph,
      TYPE: "#{Faker::Alphanumeric.alpha[0, 3]} MODEM"
    }
  end
end
