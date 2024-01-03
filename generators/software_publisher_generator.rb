# frozen_string_literal: true

class SoftwarePublisherGenerator < Generator
  def generate_data
    {
      PUBLISHER: "#{Faker::Company.name} #{Faker::Alphanumeric.alpha[0,
                                                                     2].upcase}#{Time.now.to_i} #{Faker::Alphanumeric.alpha[0,
                                                                                                                            2].upcase}#{Time.now.nsec}"
    }
  end
end
