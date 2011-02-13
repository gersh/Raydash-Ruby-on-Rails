class <%= @class_name %> < ActiveRecord::Base
  before_create :generate_token

  def point_to(otherToken)
    Raydash.changeStream(self.token,otherToken)
    self.connected_to=otherToken
    self.save()
  end
  private
    def generate_token
       self.token = Raydash.getToken()
    end
end
