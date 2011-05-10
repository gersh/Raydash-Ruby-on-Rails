module RaydashHelper

  def raydash_header()
    javascript_include_tag Raydash.getAssetUrl() + '/api/2/swfobject/1'
  end

  # This elements plays video/audio from the server
  def videostream(token, id,width="640",height="480",videoOff="0")
    javascript_tag("swfobject.embedSWF(\"" + Raydash.getAssetUrl() + "/api/2/clientbox/1\", \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{autostart:1,token:\"#{token}\",videoOff:\"#{videoOff}\"},{allowscriptaccess:'always'},{});")  +  content_tag(:div, "Video stream not available", :id => id)
  end
  # This element sends video/audio to the server
  def videorecord(token, id,width="640",height="480",hideCamera="0",videoOff="0")
    javascript_tag("function setSize(width,height,id) {if(id==undefined){id=\"#{id}\";  }document.getElementById(id).width=width;document.getElementById(id).height=height;}\n"   + "\nvar server_version=2;\nvar version=swfobject.getFlashPlayerVersion();if(version.major<10 || version.minor<3) {server_version=1;}"  + "else {server_version=2;}\nswfobject.embedSWF(\"" + Raydash.getAssetUrl() +  "/api/2/recordbox/\" + server_version , \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{hideControls:1,hideCamera:\"#{hideCamera}\",autostart:1,token:\"#{token}\",videoOff:\"#{videoOff}\"},{allowscriptaccess:'always'},{});" ) +  content_tag(:div, "Video stream not available", :id => id)
  end
end
