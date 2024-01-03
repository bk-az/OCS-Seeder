# frozen_string_literal: true

class PrintersGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Company.name,
      DRIVER: Faker::App.name,
      PORT: Faker::Alphanumeric.alphanumeric,
      DESCRIPTION: Faker::Lorem.paragraph,
      SERVERNAME: Faker::Internet.slug,
      SHARENAME: Faker::Internet.slug,
      RESOLUTION: ['300 x 300', '600 x 600', '200 x 200', '1200 x 1200'].sample,
      COMMENT: Faker::Lorem.sentence,
      SHARED: rand(0..1),
      NETWORK: rand(0..1)
    }
  end
end
