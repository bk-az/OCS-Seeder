# frozen_string_literal: true

class Db
  def self.client
    @client ||= Mysql2::Client.new(username: 'root', password: 'password', database: 'ocsweb')
  end

  def self.insert_all(table_name, data)
    return false if data.empty?

    values = data.map do |row|
      "(#{row.values.map { |value| quote(value) }.join(', ')})"
    end.join(', ')

    insert_query = "INSERT INTO `#{table_name}` (#{data[0].keys.join(', ')}) VALUES #{values};"

    client.query(insert_query)
  end

  def self.max_id(table_name)
    client.query("select max(id) as id from #{table_name};").to_a[0]['id']
  end

  def self.quote(value)
    case value
    when String, Symbol
      "'#{quote_string(value.to_s)}'"
    when true       then quoted_true
    when false      then quoted_false
    when nil        then 'NULL'
    # BigDecimals need to be put in a non-normalized form and quoted.
    when BigDecimal then value.to_s('F')
    when Numeric then value.to_s
    when Date, Time then "'#{quoted_date(value)}'"
    when Class      then "'#{value}'"
    else raise TypeError, "can't quote #{value.class.name}"
    end
  end

  def self.quote_string(s)
    s.gsub('\\', '\&\&').gsub("'", "''")
  end

  def self.quoted_true
    'TRUE'
  end

  def self.quoted_false
    'FALSE'
  end

  def self.quoted_date(value)
    value = value.utc if value.is_a?(Time)
    value.strftime("%Y-%m-%d %H:%M:%S")
  end
end
