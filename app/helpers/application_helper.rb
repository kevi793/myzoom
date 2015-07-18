module ApplicationHelper
  def logo
    image_tag("logo.png", :alt => "MyZoom", :class => "round")
  end
end
