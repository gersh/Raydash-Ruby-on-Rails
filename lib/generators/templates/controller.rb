class <%=@controller_name%> < ActiveRecord
   def index()

   end
   def show()
     @token=Raydash.getToken()
   end
   def change()
     Raydash.changeStream(params[:input_token],params[:output_token])
   end
end
