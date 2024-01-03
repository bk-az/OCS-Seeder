require_relative 'setup'

MIN_NAME_ID = 9347
MAX_NAME_ID = 10_208_347
MIN_PUBLISHER_ID = 2614
MAX_PUBLISHER_ID = 2_029_620
MIN_VERSION_ID = 11_741
MAX_VERSION_ID = 8_077_765

puts 'Loading data...'

name_ids = Db.client.query("SELECT ID FROM SOFTWARE_NAME WHERE ID >= #{MIN_NAME_ID} AND ID <= #{MAX_NAME_ID}").to_a.map(&:values).flatten
publisher_ids = Db.client.query("SELECT ID FROM SOFTWARE_PUBLISHER WHERE ID >= #{MIN_PUBLISHER_ID} AND ID <= #{MAX_PUBLISHER_ID}").to_a.map(&:values).flatten
version_ids = Db.client.query("SELECT ID FROM SOFTWARE_VERSION WHERE ID >= #{MIN_VERSION_ID} AND ID <= #{MAX_VERSION_ID}").to_a.map(&:values).flatten

puts 'Finding missing ids...'

missing_name_ids = (MIN_NAME_ID..MAX_NAME_ID).to_a - name_ids
missing_publisher_ids = (MIN_PUBLISHER_ID..MAX_PUBLISHER_ID).to_a - publisher_ids
missing_version_ids = (MIN_VERSION_ID..MAX_VERSION_ID).to_a - version_ids

puts "Inserting #{missing_name_ids.length} NAMES, #{missing_publisher_ids.length} PUBLISHERS, #{missing_version_ids.length} VERSIONS..."

names = missing_name_ids.map { |id| SoftwareNameGenerator.generate.merge(ID: id) }
Db.insert_all('software_name', names) unless names.empty?

puts "#{names.length} NAMES inserted.."

publishers = missing_publisher_ids.map { |id| SoftwarePublisherGenerator.generate.merge(ID: id) }
Db.insert_all('software_publisher', publishers) unless publishers.empty?

puts "#{publishers.length} PUBLISHERS inserted.."

versions = missing_version_ids.map { |id| SoftwareVersionGenerator.generate.merge(ID: id) }
Db.insert_all('software_version', versions) unless versions.empty?

puts "#{versions.length} VERSIONS inserted.."
