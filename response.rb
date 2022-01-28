require "json"
require_relative "./status"

class Response
  attr_accessor :status, :body, :headers

  def initialize
    @status = Status.new
    @headers = {}
    @body = body
  end

  def to_s
    <<~HTTP
    #{@status}
    #{headers_string}

    #{format_body}
    HTTP
  end

  private

    def headers_string
      @headers.map { |k, v| "#{k}: #{v}" }.join("\n")
    end

    def format_body
      return "" if @body.nil?

      if @headers["Content-Type"] == "text/html"
        html_body
      else
        json_body
      end
    end

    def html_body
      "<html><body>#{@body}</body></html>"
    end

    def json_body
      { content: @body }.to_json
    end

end

### HTTP Response

## Status line
#
# HTTP/1.1 200 OK

## Headers
#
# Access-Control-Allow-Origin: *
# Connection: Keep-Alive
# Content-Encoding: gzip
# Content-Type: text/html; charset=utf-8
# Date: Mon, 18 Jul 2016 16:06:00 GMT
# Etag: "c561c68d0ba92bbeb8b0f612a9199f722e3a621a"
# Keep-Alive: timeout=5, max=997
# Last-Modified: Mon, 18 Jul 2016 02:36:04 GMT
# Server: Apache
# Set-Cookie: mykey=myvalue; expires=Mon, 17-Jul-2017 16:06:00 GMT; Max-Age=31449600; Path=/; secure
# Transfer-Encoding: chunked
# Vary: Cookie, Accept-Encoding
# X-Backend-Server: developer2.webapp.scl3.mozilla.com
# X-Cache-Info: not cacheable; meta data too large
# X-kuma-revision: 1085259
# x-frame-options: DENY

## Body
#
# Foo bar
