require_relative "./response"
require_relative "./statuses"

class BaseResponse
  include Statuses

  attr_reader :response

  def initialize
    @response = Response.new
  end

  def etag!
    @response.headers = @response
      .headers
      .merge("ETag" => ("a".."z").to_a.sample(16).join)
  end

  def body=(body)
    validate_body!(body)
    @response.body = body
  end

  def content_type!
    raise "Not implemented."
  end

  private

    def validate_body!(body)
      raise("Bad payload.") if body.nil?
    end
end
