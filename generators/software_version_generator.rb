# frozen_string_literal: true

class SoftwareVersionGenerator < Generator
  def generate_data
    {
      VERSION: "#{rand(0..100)}.#{Time.now.nsec}.#{Faker::Alphanumeric.alpha[0, 2].downcase}.#{Time.now.to_i}"
    }
  end
end
