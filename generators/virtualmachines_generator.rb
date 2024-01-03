# frozen_string_literal: true

class VirtualmachinesGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      NAME: Faker::Alphanumeric.alphanumeric[0, 6].upcase,
      STATUS: %w[running off].sample,
      SUBSYSTEM: ['Docker Container', 'Oracle xVM VirtualBox'].sample,
      VMTYPE: 'VirtualBox',
      UUID: 4.times.map { Faker::Number.hexadecimal[0, 5].upcase }.join('-'),
      VCPU: 2**rand(1..4),
      MEMORY: 2**rand(10..16)
    }
  end
end
