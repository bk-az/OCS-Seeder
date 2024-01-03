# frozen_string_literal: true

class NetworksGenerator < Generator
  def generate_data
    {
      HARDWARE_ID: args.fetch(:HARDWARE_ID),
      DESCRIPTION: Faker::Lorem.paragraph,
      TYPE: %w[Other Ethernet Wifi Dialup].sample,
      TYPEMIB: Faker::Internet.slug,
      SPEED: "#{rand(2..200)} Mb/s",
      MTU: rand(1000..1500),
      MACADDR: Faker::Internet.mac_address.upcase,
      STATUS: %w[Down Up].sample,
      IPADDRESS: Faker::Internet.ip_v4_address,
      IPMASK: %w[0.0.0.0 255.255.255.0 255.255.0.0 255.255.254.0].sample,
      IPGATEWAY: Faker::Internet.ip_v4_address,
      IPSUBNET: Faker::Internet.ip_v4_address,
      IPDHCP: Faker::Internet.ip_v4_address,
      VIRTUALDEV: rand(0..1)
    }
  end
end
