class Status
  attr_reader :code, :message

  def initialize(code: 200, message: "OK")
    @code = code
    @message = message
  end

  def to_s
    "HTTP/1.1 #{@code} #{@message}"
  end
end
