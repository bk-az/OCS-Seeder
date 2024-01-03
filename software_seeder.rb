# frozen_string_literal: true

class SoftwareSeeder
  attr_reader :args

  # name id 9347 - 10208347
  # publisher id 2614 - 2029620
  # version id 11741 - 8077765
  def initialize(args)
    @args = args
  end

  def name_count
    (args['NAME_COUNT'] || 10_000_000).to_i
  end

  def publisher_count
    args['PUBLISHER_COUNT'] ? args['PUBLISHER_COUNT'].to_i : name_count / 5
  end

  def version_count
    args['VERSION_COUNT'] ? args['VERSION_COUNT'].to_i : (name_count / 1.25).to_i
  end

  def batch_size
    (args['BATCH_SIZE'] || 1000).to_i
  end

  def seed
    seed_records('name') unless args['SKIP_NAME']
    seed_records('publisher') unless args['SKIP_PUBLISHER']
    seed_records('version') unless args['SKIP_VERSION']
  end

  def seed_records(type)
    total = send "#{type}_count"
    progress = 0
    batches = total / batch_size
    table_name = "software_#{type}"
    max_id = Db.max_id(table_name)

    puts "\n\n#{'*' * 60}\nGenerating -- #{total} New SOFTWARE #{type.upcase}S -- MAX ID: #{max_id}"
    generator = Object.const_get("Software#{type.capitalize}Generator")
    batches.times do |_index|
      data = batch_size.times.map { generator.generate }
      Db.insert_all(table_name, data)
      progress += data.size
    rescue StandardError => e
      puts "ERROR - #{e.message}"
      puts e.backtrace.join("\n")
      break
    ensure
      print "\r[SOFTWARE #{type.upcase}] #{progress} / #{total} DONE"
    end
  rescue StandardError => e
    puts "ERROR - #{e.message}"
    puts e.backtrace.join("\n")
  ensure
    new_max_id = Db.max_id(table_name)
    records_created = new_max_id - max_id
    puts "\n#{records_created} New SOFTWARE #{type.upcase}S Created -- MAX ID: #{new_max_id}\n#{'*' * 60}\n\n"
  end
end
