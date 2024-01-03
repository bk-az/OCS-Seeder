# frozen_string_literal: true

class CpusGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      MANUFACTURER: 'Intel',
      TYPE: "Intel(R) Core(TM) i#{rand(3..10)}-#{rand(100..1000)}U CPU @ #{rand(1.0..3.5).round(2)}GHz",
      SERIALNUMBER: Faker::Number.hexadecimal.upcase,
      SPEED: rand(1800..6400),
      CORES: 2**rand(1..4),
      L2CACHESIZE: 2**rand(10..16),
      CPUARCH: 'x86_64',
      DATA_WIDTH: 64,
      CURRENT_ADDRESS_WIDTH: 64,
      LOGICAL_CPUS: 2**rand(1..4),
      VOLTAGE: '3.3 volts',
      CURRENT_SPEED: 2**rand(10..16),
      SOCKET: "CPU #00#{rand(0..4)}"
    }
  end
end
