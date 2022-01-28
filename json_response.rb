require_relative "./base_response"

class JsonResponse < BaseResponse
  def content_type!
    @response.headers = @response
      .headers
      .merge("Content-Type" => "application/json")
  end
end
