require_relative "./html_response"
require_relative "./json_response"

class BaseController
  def initialize(params:)
    @params = params
  end

  def build(name)
    raise("Dude! I can't read your mind.") unless format_valid?(name)

    Object.const_get("#{name.capitalize}Response").new
  end

  private

    def format_valid?(name)
      %i[html json].include?(name)
    end
end
