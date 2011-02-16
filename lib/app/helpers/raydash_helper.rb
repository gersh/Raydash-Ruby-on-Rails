module RaydashHelper
  def raydash_header()
    javascript_include_tag 'swfobject.js'
  end
  def videostream(token, id,width="640",height="480")
    javascript_tag("swfobject.embedSWF(\"/swfs/raydash/ClientBox.swf\", \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{autostart:1,token:\"#{token}\"})")  +  content_tag(:div, "Video stream not available", :id => id)
  end
  def videorecord(token, id,width="640",height="480")
    javascript_tag("swfobject.embedSWF(\"/swfs/raydash/RecordBox.swf\", \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{hideControls:1,hideCamera:0,autostart:1,token:\"#{token}\"})") +  content_tag(:div, "Video stream not available", :id => id)
  end
end
