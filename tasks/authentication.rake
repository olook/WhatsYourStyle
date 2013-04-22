namespace :authentication do

  desc "Creates an access token for a client app"
  task :create_access_token, :env, :app do |t, args|
    extend WhatsYourStyle::DatabaseConnectable
    set_database_connection(args[:env])
    app = WhatsYourStyle::App.create(:name => args[:app], :api_token => SecureRandom.urlsafe_base64)
    puts "Your access token is #{app.api_token}"
  end

end