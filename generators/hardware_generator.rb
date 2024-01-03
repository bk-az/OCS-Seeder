# frozen_string_literal: true

class HardwareGenerator < Generator
  OS_NAMES = {
    windows: [
      'Microsoft Windows 10 Enterprise Evaluation',
      'Microsoft Windows 10 Home',
      'Microsoft Windows 10 Home Single Language',
      'Microsoft Windows 10 Pro',
      'Microsoft Windows 11 Home',
      'Microsoft Windows 8.1 Pro',
      'Microsoft Windows Server 2016 Standard Evaluation'
    ],
    linux: [
      'CentOS Linux',
      'Ubuntu',
      'Fedora',
      'Debian',
      'Arch Linux',
      'Red Hat Enterprise Linux 7',
      'Kali Linux',
      'Gentoo Linux'
    ],
    mac: [
      'macOS'
    ],
    mobile: %w[
      Android
      iOS
    ],
    other: [
      'openSUSE Leap',
      'FreeBSD',
      'Chrome OS',
      'Raspbian'
    ]
  }.freeze

  def generate_ip_address
    Faker::Internet.ip_v4_address
  end

  OS_NAMES.each_key do |type|
    define_method("#{type}?") do
      os_type == type
    end
  end

  def os_type
    @os_type ||= args.fetch(:os_type, OS_NAMES.keys.sample).to_sym
  end

  def os_name
    @os_name ||= OS_NAMES[os_type].sample
  end

  def device_name
    @device_name ||= Faker::Alphanumeric.alpha[0, 8].upcase
  end

  def device_id
    @device_id ||= "#{device_name}-#{generate_random_date.strftime('%Y-%m-%d-%H-%M-%S')}"
  end

  def os_version
    @os_version ||= "#{rand(0..100)}.#{rand(0..100)}.#{rand(1000..999_99)}"
  end

  def processort
    @processort ||= "Intel(R) Core(TM) i#{rand(3..10)}-#{rand(100..1000)}U CPU @ #{rand(1.0..3.5).round(2)}GHz [#{rand(1..8)} core(s) x86_64]"
  end

  def user_agent
    @user_agent ||= "OCS-NG_#{os_type.upcase}_AGENT_v2.#{rand(1..10)}.#{rand(0..5)}.#{rand(0..10)}"
  end

  def last_date
    @last_date ||= generate_random_date
  end

  def last_come
    @last_come ||= last_date + rand(0..10)
  end

  def win_company
    return unless windows?

    Faker::Device.manufacturer
  end

  def win_owner
    return unless windows?

    Faker::Internet.email
  end

  def win_prod_id
    return unless windows?

    4.times.map { Faker::Number.hexadecimal[0, 5].upcase }.join('-')
  end

  def win_prod_key
    return unless windows?

    5.times.map { Faker::Number.hexadecimal[0, 5].upcase }.join('-')
  end

  def generate_data
    {
      DEVICEID: device_id,
      NAME: device_name,
      WORKGROUP: Faker::Internet.domain_name,
      USERDOMAIN: Faker::Company.name,
      OSNAME: os_name,
      OSVERSION: os_version,
      OSCOMMENTS: Faker::Lorem.sentence,
      PROCESSORT: processort,
      PROCESSORS: rand(1000..5000),
      PROCESSORN: rand(1..8),
      MEMORY: Faker::Number.between(from: 1024, to: 32_768),
      SWAP: Faker::Number.between(from: 0, to: 4096),
      IPADDR: generate_ip_address,
      DNS: "127.0.0.#{rand(1..100)}",
      DEFAULTGATEWAY: "192.168.#{rand(0..10)}.#{rand(1..100)}",
      LASTDATE: last_date,
      LASTCOME: last_come,
      QUALITY: Faker::Number.decimal(l_digits: 2, r_digits: 4),
      FIDELITY: rand(1..1000),
      USERID: Faker::Internet.user_name,
      TYPE: Faker::Number.between(from: 0, to: 1),
      DESCRIPTION: Faker::Lorem.sentence,
      WINCOMPANY: win_company,
      WINOWNER: win_owner,
      WINPRODID: win_prod_id,
      WINPRODKEY: win_prod_key,
      USERAGENT: user_agent,
      CHECKSUM: Faker::Number.number(digits: 6),
      SSTATE: Faker::Number.between(from: 0, to: 1),
      IPSRC: generate_ip_address,
      UUID: Faker::Internet.uuid,
      ARCH: 'x86 64 bit'
    }
  end
end
