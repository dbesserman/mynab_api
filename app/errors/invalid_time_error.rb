class InvalidTimeError < StandardError
  def initialize(message)
    super
    @message = message
  end
end
