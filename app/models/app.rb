module WhatsYourStyle
  class App < ActiveRecord::Base
    attr_accessible :name, :api_token
  end
end