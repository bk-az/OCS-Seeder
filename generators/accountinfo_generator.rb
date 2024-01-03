# frozen_string_literal: true

class AccountinfoGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      TAG: args.fetch(:tag)
    }
  end
end
