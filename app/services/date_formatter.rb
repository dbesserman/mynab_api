class DateFormatter
  TIME_FORMAT = '%c'.freeze

  def initialize(date)
    raise InvalidTimeError, 'The date does not implement :strftime' unless valid_date?(date)
    @date = date
  end

  def perform
    @date.strftime(TIME_FORMAT)
  end

  private

  def valid_date?(date)
    date.public_methods.include?(:strftime)
  end
end
