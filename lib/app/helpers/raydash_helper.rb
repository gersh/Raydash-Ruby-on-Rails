module RaydashHelper
  def raydash_header()
    javascript_include_tag 'swfobject.js'
  end
  # This elements plays video/audio from the server
  def videostream(token, id,width="640",height="480",videoOff="0")
    javascript_tag("swfobject.embedSWF(\"/swfs/raydash/ClientBox.swf\", \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{autostart:1,token:\"#{token}\",videoOff:\"#{videoOff}\"})")  +  content_tag(:div, "Video stream not available", :id => id)
  end
  # This element sends video/audio to the server
  def videorecord(token, id,width="640",height="480",hideCamera="0",videoOff="0")
    javascript_tag("function setSize(width,height,id) {if(id==undefined){id=\"#{id}\";  }document.getElementById(id).width=width;document.getElementById(id).height=height;} swfobject.embedSWF(\"/swfs/raydash/RecordBox.swf\", \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{hideControls:1,hideCamera:\"#{hideCamera}\",autostart:1,token:\"#{token}\",videoOff:\"#{videoOff}\"});") +  content_tag(:div, "Video stream not available", :id => id)
  end
end
