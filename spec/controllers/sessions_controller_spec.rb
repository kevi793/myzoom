require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    # it "should have the right title" do
    #   get :new
    #   #debugger
    #   expect(rendered).to have_tag('title', :text => 'Sign in')
    # end
  end


  describe "POST #create" do

    before(:each) do
      @attr = {:email => "email@example.com", :password => "password"}
      expect(User).to receive(:find_by).and_return(User.new)
    end

    context "invalid signin" do
      it "should redirect the new page" do
        expect_any_instance_of(User).to receive(:authenticate).and_return(false)
        post :create, :session => @attr
        debugger
        expect(response).to redirect_to('/signin')
      end
    end

    context "valid signin" do
      it "should redirect to users page" do
        expect_any_instance_of(User).to receive(:authenticate).and_return(true)
        post :create, :session => @attr
      end
    end

  end

end
