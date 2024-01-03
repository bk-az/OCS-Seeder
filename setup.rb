# frozen_string_literal: true

require 'bundler/setup'
Bundler.require

require_relative 'db'
require_relative 'software_seeder'
require_relative 'hardware_seeder'

require_relative 'generators/generator'
generator_directory = File.expand_path('generators', __dir__)
# Require all Ruby files in the generators directory
Dir[File.join(generator_directory, '*.rb')].each { |file| require file }
