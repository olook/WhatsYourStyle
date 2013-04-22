module WhatsYourStyle
  module DatabaseConnectable
    def set_database_connection(env='development')
      ActiveRecord::Base.configurations = WhatsYourStyle::Application.database_config
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[env])
    end
  end
end