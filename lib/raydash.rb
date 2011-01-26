require 'net/http'
module Raydash
  RAYDASH_HTTP_SERVER = "api.raydash.com"
  RAYDASH_HTTP_PORT = "8080"

  mattr_accessor :userid
  mattr_accessor :secret

  def self.doRequest(request)
    Net::HTTP.get(RAYDASH_HTTP_SERVER, request, RAYDASH_HTTP_PORT)
  end
  def self.getToken(streamName="")
    result = self.doRequest("/api/1/authtoken/" + streamName + "?userid=" + self.userid + "&secret=" & self.secret)
    throw "Unable to create token" if result!=200
    return result.body
  end
  def self.changeStream(output_token,input_token)
    result = def.doRequest("/api/1/changeSteam/" + output_token + "/" + input_token "&userid=" + self.userId + "&secret=" & self.secret)
    throw "Unable to create token" if result!=200
    return result.body
  end
  # Your code goes here...
end
