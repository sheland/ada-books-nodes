require "test_helper"

describe SessionsController do
  it "login form" do
    get login_path

    must_respond_with :success
  end

  describe "login action" do
    it  "can create a new user" do
      user_hash = {
        author: {
          name: "Katie"
        }
      }

      expect {
        post login_path, params: user_hash
      }.must_change "Author.count", 1

      new_author = Author.find_by(name: user_hash[:author][:name]

      expect(new_author).wont_be_nil
      expect(session[:user_id])
    end

    it "should log in existing user without changing"
    end

    it "shoud give a bad request for an invalid author"
    end 
