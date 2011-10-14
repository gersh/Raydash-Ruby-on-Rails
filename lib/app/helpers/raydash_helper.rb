module RaydashHelper

  def raydash_header()
    javascript_include_tag Raydash.getAssetUrl() + '/api/2/swfobject/1'
  end

  # This elements plays video/audio from the server
  def videostream(token, id,width="640",height="480",videoOff="0",autostart="1")
    javascript_tag("swfobject.embedSWF(\"" + Raydash.getAssetUrl() + "/api/2/clientbox/1\", \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{autostart:#{autostart},token:\"#{token}\",videoOff:\"#{videoOff}\"},{allowscriptaccess:'always',wmode:'transparent'},{});")  +  content_tag(:div, "Video stream not available", :id => id)
  end
  # This element sends video/audio to the server
  def videorecord(token, id,width="640",height="480",hideCamera="0",videoOff="0",microphoneOff="0",autostart="1")
    javascript_tag("function setSize(width,height,id) {if(id==undefined){id=\"#{id}\";  }document.getElementById(id).width=width;document.getElementById(id).height=height;}\n"   + "\nvar server_version=2;\nvar version=swfobject.getFlashPlayerVersion();if(version.major<10 || version.minor<3) {server_version=1;}"  + "else {server_version=2;}\nswfobject.embedSWF(\"" + Raydash.getAssetUrl() +  "/api/2/recordbox/\" + server_version , \"#{id}\",#{width},#{height},\"9.0.0\",\"http://www.adobe.com/products/flashplayer/download\",{hideControls:1,hideCamera:\"#{hideCamera}\",autostart:#{autostart},token:\"#{token}\",videoOff:\"#{videoOff}\",microphoneOff:\"#{microphoneOff}\"},{allowscriptaccess:"always",wmode:"transparent"},{});" ) +  content_tag(:div, "Video stream not available", :id => id)
  end
  def video_selector(record_id,video_selector_id ="video_selector_id")
    javascript_tag(<<-CODE
jQuery(document).ready(function($){
var camerasEl;
var cameraInterval=setInterval(function(){
        camerasEl = document.getElementById("#{record_id}");
        if(camerasEl != undefined && camerasEl.getCameras && camerasEl.getCameras()) {
            clearInterval(cameraInterval);
            var cameras=camerasEl.getCameras();
            for(var i in cameras) {
                $("##{video_selector_id}").append("<option value=\\"" +i +"\\">" + cameras[i] + "</option>\\n");
            }
        }
    },500);
    $("##{video_selector_id}_btn").click(function(){
             camerasEl.changeCamera($("##{video_selector_id}").val());
     });

});
CODE
     ) +
    content_tag(:select,"",:id => video_selector_id) +
    content_tag(:button,"Change Video",:id=>video_selector_id + "_btn")
  end
  def audio_selector(record_id,audio_selector_id="audio_selector_id")
    javascript_tag(<<-CODE
jQuery(document).ready(function($){
      var audioEl;
      var audioInterval=setInterval(function() {
       audioEl = document.getElementById("#{record_id}");
       if(audioEl != undefined && audioEl.getMicrophones && audioEl.getMicrophones()) {
            clearInterval(audioInterval);
            var microphones = audioEl.getMicrophones();
            for(var i in microphones) {
                 $("##{audio_selector_id}").append("<option value=\\"" + i + "\\">" + microphones[i] + "</option>\\n");
            }
       }
     },500);
     $("##{audio_selector_id}_btn").click(function(){
             audioEl.changeMicrophone($("##{audio_selector_id}").val());
       });
});
CODE
) +
    content_tag(:select,"", :id=> audio_selector_id) +
    content_tag(:button,"Change Audio",:id => audio_selector_id + "_btn")
  end
end
