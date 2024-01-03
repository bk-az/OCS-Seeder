# frozen_string_literal: true

class VideosGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Alphanumeric.alpha[0, 6].upcase,
      CHIPSET: "#{Faker::Device.manufacturer} #{Faker::Alphanumeric.alpha[0, 3].upcase}",
      MEMORY: (2**rand(10..16)).to_s,
      RESOLUTION: "#{rand(700..2000)} x #{rand(700..2000)}"
    }
  end
end
