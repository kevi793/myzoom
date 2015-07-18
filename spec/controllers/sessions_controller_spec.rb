require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "POST #create" do


    context "invalid signin" do
      it "should redirect the new page" do
        @attr = {:email => "email@example.com", :password => "password"}
        expect(User).to receive(:find_by).and_return(User.new)
        expect_any_instance_of(User).to receive(:authenticate).and_return(false)
        post :create, :session => @attr
        expect(response).to redirect_to('/signin')
      end
    end

    context "valid signin" do

      before(:each) do
        @user = User.find_by(:email => 'example@gmail.com') || FactoryGirl.create(:user)
        @attr = {:email => @user.email,:password => "password"}
        expect_any_instance_of(User).to receive(:authenticate).with(@attr[:password]).and_return(true)
      end

      it "should sign the user in" do
        post :create, :session => @attr
        expect(response).to have_http_status(:redirect)
      end

      it "should redirect to show user page" do
        post :create, :session => @attr
        expect(response).to redirect_to(user_path(@user))
      end

    end

  end

end
