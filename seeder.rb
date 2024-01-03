# frozen_string_literal: true

require_relative 'setup'

class Seeder
  attr_reader :args

  SEED_TYPES = %w[
    software
    hardware
    hardware_installations
    hardware_associations
  ].freeze

  def initialize(args = {})
    @args = process_options(args)
    handle_errors
  end

  def seed
    case args['TYPE']
    when 'software'
      # ruby seeder.rb TYPE=software NAME_COUNT=10000000 BATCH_SIZE=1000
      SoftwareSeeder.new(args).seed
    when 'hardware'
      # ruby seeder.rb TYPE=hardware HARDWARE_COUNT=250000 MIN_NAME_ID=9347 MAX_NAME_ID=10208347 MIN_PUBLISHER_ID=2614 MAX_PUBLISHER_ID=2029620 MIN_VERSION_ID=11741 MAX_VERSION_ID=8077765
      HardwareSeeder.new(args).seed
    end
  end

  private

  def process_options(args)
    args.to_h { |e| e.split('=').map(&:strip) }
  end

  def handle_errors
    return if SEED_TYPES.include?(args['TYPE'])

    abort("Invalid value for `TYPE` argument, valid values include:\n -> #{SEED_TYPES.join("\n -> ")}")
  end
end

Seeder.new(ARGV).seed
