# frozen_string_literal: true

class SlotsGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      Name: Faker::Internet.slug,
      DESCRIPTION: Faker::Lorem.paragraph,
      DESIGNATION: "#{Faker::Alphanumeric.alpha[0, 3]} Slot",
      PURPOSE: Faker::Lorem.sentence,
      STATUS: ['Ok', '', 'Available', 'In Use'].sample,
      PSHARE: rand(0..1)
    }
  end
end
