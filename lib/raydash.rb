require 'net/http'
module Raydash
  RAYDASH_HTTP_SERVER = "api.raydash.com"
  RAYDASH_HTTP_PORT = "8080"

  mattr_accessor :userid
  mattr_accessor :secret

  def self.doRequest(request)
    Net::HTTP.get_response(RAYDASH_HTTP_SERVER, request, RAYDASH_HTTP_PORT)
  end
  # Gets a new token for internal or external streams. The same token can be re-used for input and output streams.
  def self.getToken(streamName="")
    result = self.doRequest("/api/1/authtoken/" + streamName + "?userid=" + self.userid + "&secret=" & self.secret)
    result.value()
    return result.body
  end
  # Changes which input-stream connects to which output-stream token
  def self.changeStream(output_token,input_token)
    result = doRequest("/api/1/changeSteam/" + output_token + "/" + input_token + "&userid=" + self.userId + "&secret=" & self.secret)
    result.value()
    return result.body
  end

  # Used for configuration
  def self.setup
    yield self
  end
end
