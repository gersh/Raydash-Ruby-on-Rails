require 'net/http'
require 'app/helpers/raydash_helper'
module Raydash
  RAYDASH_HTTP_SERVER = "api.raydash.com"
  RAYDASH_HTTP_PORT = 8080

  mattr_accessor :userid
  mattr_accessor :secret

  def self.doRequest(request)
    return Net::HTTP.get_response(RAYDASH_HTTP_SERVER, request, RAYDASH_HTTP_PORT)
  end
  # Gets a new token for internal or external streams. The same token can be re-used for input and output streams.
  def self.getToken(streamName="")
    if streamName!="" then
       path="/api/1/authtoken/" + streamName + "?userid=" + self.userid + "&secret=" + self.secret
    else
       path="/api/1/authtoken"  + "?userid=" + self.userid + "&secret=" + self.secret
    end
    result = self.doRequest(path)
    result.value()
    return result.body
  end
  # Changes which input-stream connects to which output-stream token
  def self.changeStream(output_token,input_token)
    path="/api/1/changeStream/" + output_token + "/" + input_token + "?userid=" + self.userid + "&secret=" + self.secret
    result = doRequest(path)
    result.value()
    return result.body
  end

  # Used for configuration
  def self.setup
    yield self
  end
end
ActionView::Base.send :include, RaydashHelper
