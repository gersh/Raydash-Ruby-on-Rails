require 'net/http'
require 'app/helpers/raydash_helper'
require 'json'
module Raydash
  RAYDASH_HTTP_SERVER = "api.raydash.com"
  RAYDASH_HTTP_PORT = 8080
  CLIENTBOX_VERSION = "1"
  RECORDBOX_VERSION = "2"
  mattr_accessor :userid
  mattr_accessor :secret
  self.userid = ENV['RAYDASH_USERID']
  self.secret = ENV['RAYDASH_SECRET']


  # Gets a new token for internal or external streams. The same token can be re-used for input and output streams.
  def self.getToken(streamName="", echoGroup="",customGroup="")
    if streamName!="" then
      #       path="/api/2/authtoken/" + streamName + "?userid=" + self.userid + "&secret=" + self.secret
      result=self.postRequest("/api/2/authtoken",{'userid'=>self.userid,'secret'=>self.secret,'streamName'=>streamName,'echoGroup'=>echoGroup,'customGroup'=>customGroup,'streamName'=>streamName})
    else
      # path="/api/2/authtoken"  + "?userid=" + self.userid + "&secret=" + self.secret
      result=self.postRequest("/api/2/authtoken",{'userid'=>self.userid,'secret'=>self.secret,'streamName'=>streamName,'echoGroup'=>echoGroup,'customGroup'=>customGroup})
    end
    return result.body
  end
  # Changes which input-stream connects to which output-stream token
  def self.changeStream(output_token,input_token)
    result = postRequest("/api/2/authtoken/#{output_token}",{'streamName'=>input_token, 'userid' => self.userid, 'secret' => self.secret, })
    return result.body
  end
  def self.changeStreamNext(output_token,customGroup="",active="",echoGroup="")
    result = postRequest("/api/2/authtoken/#{output_token}/next?customGroup=#{customGroup}&active=#{active}&echoGroup=#{activeGroup}")
    return result.body
  end

  def self.changeStreamRand(output_token,input_token,customGroup="",active="",echoGroup="")
    result = postRequest("/api/2/authtoken/#{output_token}/randnext?echoGroup=#{echoGroup}&customGroup=#{customGroup}&active=#{active}")
    return result.body
  end
  # Gets information about the stream
  def self.getStreamInfo(token)
    path="/api/2/authtoken/#{token}" + token + "?userid=" + self.userid + "&secret=" + self.secret
    result = getRequest(path)
    return JSON.parse(result.body)
  end
  # Sets a callback url with three parameters
  def self.setCallbackUrl(userid, secret, url)
    path="/api/2/callbackurl/"  + "?userid=" + self.userid  + "&secret=" + self.secret + "&url=" + CGI::escape(url)
    result = doRequest(path)
    result.value()
    return JSON.parse(result.body)
  end

  # Used for configuration
  def self.setup
    yield self
  end

  private
  def self.getRequest(request)
    return Net::HTTP.get_response(RAYDASH_HTTP_SERVER, request, RAYDASH_HTTP_PORT)
  end
  def self.postRequest(request)
    return Net::HTTP.post_form("http://" + RAYDASH_HTTP_SERVER + ":" + RAYDASH_HTTP_PORT.to_s(), request)
  end
end
ActionView::Base.send :include, RaydashHelper
