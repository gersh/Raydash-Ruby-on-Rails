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

  def self.getAssetUrl()
    "http://" + RAYDASH_HTTP_SERVER + ":" + RAYDASH_HTTP_PORT.to_s()
  end
  # Gets a new token for internal or external streams. The same token can be re-used for input and output streams.
  def self.getToken(streamName="", customGroup="")
    if streamName!="" then
      result=self.postRequest("/api/2/authtoken",{'userid'=>self.userid,'secret'=>self.secret,'streamName'=>streamName,'customGroup'=>customGroup})
    else
      result=self.postRequest("/api/2/authtoken",{'userid'=>self.userid,'secret'=>self.secret,'customGroup'=>customGroup})
    end
    return result.body
  end
  # Changes which input-stream connects to which output-stream token
  def self.changeStream(output_token,input_token)
    result = postRequest("/api/2/authtoken/#{output_token}",{'streamName'=>input_token, 'userid' => self.userid, 'secret' => self.secret, })
    return result.body
  end
  def self.changeStreamNext(output_token,params={})
    customGroup=params[:customGroup]
    active=params[:active]
    twoWay=params[:twoWay]
    newCustomGroup=params[:newCustomGroup]

    path="/api/2/authtoken/#{output_token}/next?userid=#{userid}&secret=#{secret}"

    if active!=nil then
      path += "&active=#{active}"
    end
    if customGroup!=nil then
      path += "&customGroup=#{customGroup}"
    end
    if twoWay!=nil && (twoWay=="1" || twoWay==true)
      path += "&twoWay=1"
    end
    if newCustomGroup!=nil
      path += "&newCustomGroup=#{customGroup}"
    end
    result = getRequest(path)
    return result.body
  end

  # Change to a random stream with the specified customGoup
  def self.changeStreamRand(output_token,params={})
    customGroup=params[:customGroup]
    active=params[:active]
    twoWay=params[:twoWay]
    newCustomGroup=params[:newCustomGroup]

    path="/api/2/authtoken/#{output_token}/randnext?userid=#{userid}&secret=#{secret}"
    if customGroup!=nil then
      path += "&customGroup=#{customGroup}"
    end
    if active!=nil then
      path += "&active=#{active}"
    end
    if twoWay!=nil && (twoWay=="1" || twoWay==true)
      path += "&twoWay=1"
    end
    if newCustomGroup!=nil
      path += "&newCustomGroup=#{customGroup}"
    end
    result = getRequest(path)
    return result.body
  end

  # Gets information about the stream
  def self.getStreamInfo(token)
    path="/api/2/authtoken/" + token + "?userid=" + self.userid + "&secret=" + self.secret
    result = getRequest(path)
    return JSON.parse(result.body)
  end
  # Sets a callback url with three parameters
  def self.setCallbackUrl(userid, secret, url)
    path="/api/2/callbackurl/"  + "?userid=" + self.userid  + "&secret=" + self.secret + "&url=" + CGI::escape(url)
    result = getRequest(path)
    result.value()
    return JSON.parse(result.body)
  end
  def self.startRecord(token)
    path="/api/2/startRecord/#{token}"
    result = self.getRequest(path + "?userid=#{self.userid}&secret=#{self.secret}")
    return result.body
  end
  def self.stopRecord(token,bucket)
    path="/api/2/stopRecord/#{token}"
    result = self.getRequest(path + "?userid=#{self.userid}&secret=#{self.secret}&bucket=#{CGI::escape(bucket)}")
    return result.body
  end
  def self.setUserInfo(amazonKey,amazonSecret,callbackUrl="")
    path="/api/2/user/#{self.userid}"
    postRequest(path,{'userid'=>self.userid,'secret'=>self.secret,'amazonSecret'=>amazonSecret,'amazonKey'=>amazonKey})
  end
  # Used for configuration
  def self.setup
    yield self
  end

  private
  def self.getRequest(request)
    http=Net::HTTP.new(RAYDASH_HTTP_SERVER,RAYDASH_HTTP_PORT)
    http.read_timeout=20
    http.open_timeout=20
    return http.request_get(request)
  end
  def self.postRequest(path,request)
    http=Net::HTTP.new(RAYDASH_HTTP_SERVER,RAYDASH_HTTP_PORT)
    http.read_timeout=20
    http.open_timeout=20

    return http.request_post(path, request.to_query)
  end


end
ActionView::Base.send :include, RaydashHelper
