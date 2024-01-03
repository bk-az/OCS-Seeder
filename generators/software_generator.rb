# frozen_string_literal: true

class SoftwareGenerator < Generator
  def language
    ['Language Neutral',
     'English (United States)',
     'English',
     'Turkish (Turkey)',
     'Japanese (Japan)',
     'Chinese (Traditional, Taiwan)',
     'Italian (Italy)',
     'Czech (Czech Republic)',
     'Russian (Russia)',
     'German (Germany)',
     'Portuguese (Brazil)',
     'Spanish (Spain, International Sort)',
     'French (France)',
     'Korean (Korea)',
     'Polish (Poland)',
     'Chinese (Simplified, China)'].sample
  end

  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME_ID: args.fetch(:NAME_ID),
      PUBLISHER_ID: args.fetch(:PUBLISHER_ID),
      VERSION_ID: args.fetch(:VERSION_ID),
      FOLDER: Faker::File.dir,
      COMMENTS: Faker::Lorem.paragraph,
      FILENAME: Faker::File.file_name,
      FILESIZE: rand(0..10_000_000),
      SOURCE: rand(0..1),
      GUID: "{#{Faker::Alphanumeric.alphanumeric.upcase}-#{Faker::Number.hexadecimal.upcase}-#{Faker::Number.hexadecimal.upcase}-#{Faker::Alphanumeric.alphanumeric.upcase}}",
      LANGUAGE: language,
      INSTALLDATE: generate_random_date,
      BITSWIDTH: [32, 64].sample,
      ARCHITECTURE: %w[amd64 all i386].sample
    }
  end
end
