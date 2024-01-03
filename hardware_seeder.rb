# frozen_string_literal: true
class HardwareSeeder
  attr_reader :args, :name_id_range, :publisher_id_range, :version_id_range

  def initialize(args)
    @args = args
    @name_id_range = args.fetch('MIN_NAME_ID').to_i..args.fetch('MAX_NAME_ID').to_i
    @publisher_id_range = args.fetch('MIN_PUBLISHER_ID').to_i..args.fetch('MAX_PUBLISHER_ID').to_i
    @version_id_range = args.fetch('MIN_VERSION_ID').to_i..args.fetch('MAX_VERSION_ID').to_i
  end

  def tags
    @tags ||= YAML.load_file('tags.yml')
  end

  def hardware_count
    @hardware_count ||= (args['HARDWARE_COUNT'] || 250_000).to_i
  end

  def max_software_count
    @max_software_count ||= (args['MAX_SOFTWARE_COUNT'] || 500).to_i
  end

  def min_software_count
    @min_software_count ||= (args['MIN_SOFTWARE_COUNT'] || 50).to_i
  end

  def seed
    total = hardware_count
    progress = 0
    table_name = 'hardware'
    max_id = Db.max_id(table_name)

    puts "\n\n#{'*' * 60}\nGenerating -- #{total} New HARDWARES -- MAX ID: #{max_id}"
    total.times do |_index|
      tag = tags.sample
      hardware = create_hardware
      options = {
        tag:,
        hardware:,
        HARDWARE_ID: hardware[:ID]
      }
      create_hardware_associations(options)
      progress += 1
    rescue StandardError => e
      puts "ERROR - #{e.message}"
      puts e.backtrace.join("\n")
      break
    ensure
      print "\r[HARDWARE] #{progress} / #{total} DONE"
    end
  rescue StandardError => e
    puts "ERROR - #{e.message}"
    puts e.backtrace.join("\n")
  ensure
    new_max_id = Db.max_id(table_name)
    records_created = new_max_id - max_id
    puts "\n#{records_created} New HARDWARES Created -- MAX ID: #{new_max_id}\n#{'*' * 60}\n\n"
  end

  def create_hardware
    hardware_attrs = HardwareGenerator.generate
    Db.insert_all('hardware', [hardware_attrs])

    hardware_attrs.merge(ID: Db.max_id('hardware'))
  end

  def create_hardware_associations(options)
    create_softwares(options)
    create_associations('accountinfo', options, 1)
    create_associations('bios', options, 1)
    create_associations('controllers', options, rand(1..10))
    create_associations('cpus', options, rand(1..8))
    create_associations('devices', options, rand(1..10))
    create_associations('drives', options, rand(1..10))
    create_associations('inputs', options, rand(1..10))
    create_associations('memories', options, rand(1..4))
    create_associations('modems', options, rand(1..10))
    create_associations('monitors', options, rand(1..3))
    create_associations('networks', options, rand(1..10))
    create_associations('ports', options, rand(1..10))
    create_associations('printers', options, rand(1..10))
    create_associations('slots', options, rand(1..10))
    create_associations('sounds', options, rand(1..2))
    create_associations('storages', options, rand(1..4))
    create_associations('videos', options, rand(1..2))
    create_associations('virtualmachines', options, rand(1..4))
  end

  def create_softwares(options)
    total = rand(min_software_count..max_software_count)
    used_name_ids = Set.new
    used_publisher_ids = Set.new
    used_version_ids = Set.new
    data = total.times.map do |_index|
      name_id = software_association_id('name', used_name_ids)
      publisher_id = software_association_id('publisher', used_publisher_ids)
      version_id = software_association_id('version', used_version_ids)
      args = options.merge(NAME_ID: name_id, PUBLISHER_ID: publisher_id, VERSION_ID: version_id)
      SoftwareGenerator.generate(**args)
    end
    Db.insert_all('software', data)
  end

  def software_association_id(type, ids)
    id = nil
    loop do
      id = rand(send("#{type}_id_range"))
      break unless ids.include?(id)
    end

    ids << id
    id
  end

  def create_associations(table, options, count)
    generator = Object.const_get("#{table.capitalize}Generator")
    data = count.times.map { generator.generate(**options) }
    Db.insert_all(table, data)
  end
end
