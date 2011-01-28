module RaydashHelper
  def raydash_header()
    javascript_include_tag 'swfobject.js'
  end
  def videostream(token, id,width="300",height="100")
    javascript_tag('swfobject.embedSWF("/swf/raydashstream.swf", "#{id}","9.0.0","http://www.adobe.com/products/flashplayer/download","token=#{token}")</script><div id="#{id}">Video stream not available</div>')
  end
  def videorecord(token, id,width="300",height="100")
      javascript_tag('swfobject.embedSWF("/swf/raydashrecord.swf", "#{id}","9.0.0","http://www.adobe.com/products/flashplayer/download","token=#{token}")</script><div id="#{id}">Video stream not available</div>')
  end
end
