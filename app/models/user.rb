class User < ApplicationRecord
  #create new method
  #should accept the auth_hash as a parameter and construct a new User
  #save it to the database using the info from the auth_hash
  def self.bulid_from_omniAuth(auth_hash)
    user = User.new

      user.provider = "github"
      user.name = auth_hash["info"]["name"]
      user.email = auth_hash["info"]["email"]
      user.uid = auth_hash["uid"]
    end
  end
end
