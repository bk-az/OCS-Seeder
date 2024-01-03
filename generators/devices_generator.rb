# frozen_string_literal: true

class DevicesGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Alphanumeric.alpha[0, 6].upcase,
      IVALUE: rand(1..10),
      TVALUE: Faker::Internet.ip_v4_address,
      COMMENTS: Faker::Lorem.paragraph
    }
  end
end
