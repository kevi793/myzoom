class DemoController < ApplicationController
  def index
    render json: {:name => "vivek"}
  end
end
