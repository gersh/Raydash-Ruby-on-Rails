module RaydashHelper
  def header()
    '<script type="text/javascript" src="/scripts/swfobject.js"></script>'
  end
  def videostream(token, id,width="300",height="100")
    '<script type="text/javascript">swfobject.embedSWF("/swf/raydashstream.swf", "#{id}","9.0.0","http://www.adobe.com/products/flashplayer/download","token=#{token}")</script><div id="#{id}">Video stream not available</div>'
  end
  def viderecord(token, id,width="300",height="100")
      '<script type="text/javascript">swfobject.embedSWF("/swf/raydashrecord.swf", "#{id}","9.0.0","http://www.adobe.com/products/flashplayer/download","token=#{token}")</script><div id="#{id}">Video stream not available</div>'
  end
end
