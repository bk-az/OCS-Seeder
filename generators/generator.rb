# frozen_string_literal: true

class Generator
  attr_reader :args

  def initialize(**args)
    @args = args
  end

  def data
    @data ||= generate_data
  end

  def self.generate(**args)
    new(**args).data
  end

  private

  def generate_random_date(start_date = DateTime.now - 365, end_date = DateTime.now)
    Faker::Time.between_dates(from: start_date, to: end_date, period: :all).to_time
  end
end
