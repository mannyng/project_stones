require 'rails_helper'

RSpec.describe "routing to administrator", :type => :routing do

 it "routes /administrator/:id to administrator#show for id" do
    expect(:get => "/administrators/kdiru-9jje-4iem-3kieo").to route_to(
      :controller => "administrators",
      :action => "show",
      :id => "kdiru-9jje-4iem-3kieo" )
     end

  it "does not expose a list of ids" do
    expect(:get => "/administrators"). not_to be_routable
  end

end
