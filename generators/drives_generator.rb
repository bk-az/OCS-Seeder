# frozen_string_literal: true

class DrivesGenerator < Generator
  def file_system
    if args[:hardware][:WINPRODKEY]
      'NTFS'
    else
      %w[apfs hfs devtmpfs xfs ext4].sample
    end
  end

  def total
    @total ||= rand(1024..10_000_000)
  end

  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      LETTER: args[:hardware][:WINPRODKEY] ? "#{Faker::Alphanumeric.alpha[0].upcase}:" : '',
      TYPE: Faker::File.dir,
      FILESYSTEM: file_system,
      TOTAL: total,
      FREE: [0, total - rand(0..100_000)].max,
      NUMFILES: 0,
      VOLUMN: Faker::File.dir,
      CREATEDATE: generate_random_date
    }
  end
end
