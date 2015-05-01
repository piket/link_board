require 'rails_helper'
require 'factory_girl_rails'

describe "User Testing" do

    describe "GET /users/new" do
        it "should exist" do
            get "/users/new"
            expect(response).to be_success
        end
        it "should return the new route" do
            get "/users/new"
            expect(response).to render_template(:new)
        end
    end

    describe "POST /users" do
        it "should take form parameters and create a user" do
            post "/users", :user => {:name => "Tester", :email => "tester@test.test", :password => "12345678" }
            expect(response).to redirect_to "/login"
            follow_redirect!
        end
        it "should reject incorrect information" do
            post "/users", :user => {:name => "qwertyuiopasdfghjklzxcvbnm", :email => "qwerty.yio", :password => "98"}
            expect(response).to render :new
            follow_redirect!
        end
    end
  # pending "add some examples to (or delete) #{__FILE__}"
end
