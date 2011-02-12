class <%=@controller_name%>Controller < ActiveRecord
   def index()
      @videos = <%= @model_name %>.all
   end
   def show()
      @video = <%= @model_name %>.find(params[:id])
   end
   def new()
      @video = <%= @model_name %>.new
   end
   def edit
      @video = <%= @model_name %>.find(params[:id])
   end
   def create
      @video = <%= @model_name %>.new()
      if @video.save
         redirect_to(@video, :notice => 'Video stream was successfully created')
      else
         render :action => "new"
      end
   end
   def destroy
      @video = <%= @model_name %>.find(params[:id])
      @video.destroy
      redirect_to <%= @controller_name.downcase %>_url
   end
   def connect()
     @video1 = <%= @model_name %>.find(params[:id])
     @video2 = <%= @model_name %>.find(params[:video_connect])
     @video1.point_to(@video2.token)
     redirect_to <%= @controller_name.downcase %>_url 
   end
end
