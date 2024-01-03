# frozen_string_literal: true

class SoftwareNameGenerator < Generator
  def generate_data
    {
      NAME: "#{Faker::App.name} #{Faker::Alphanumeric.alpha[0,
                                                            2].upcase}#{Time.now.to_i} #{Faker::Alphanumeric.alpha[0,
                                                                                                                   2].upcase}#{Time.now.nsec}"
    }
  end
end
