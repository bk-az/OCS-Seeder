# frozen_string_literal: true

class MemoriesGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      CAPTION: Faker::Lorem.sentence,
      DESCRIPTION: Faker::Lorem.paragraph,
      CAPACITY: 2**rand(10..16),
      PURPOSE: Faker::Lorem.sentence,
      TYPE: "#{Faker::Alphanumeric.alpha[0, 3]} RAM",
      SPEED: "#{rand(2000..4000)} MHz",
      NUMSLOTS: rand(100..300),
      SERIALNUMBER: Faker::Number.hexadecimal.upcase
    }
  end
end
