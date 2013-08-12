$: << File.dirname(__FILE__)
require 'whats_your_style'

module WhatsYourStyle
  class API < Grape::API

    extend DatabaseConnectable

    set_database_connection(Goliath.env.to_s)

    # Take this options to be passed as a parameter for the client APP
    DUMMY_QUESTIONS = Application.app_config['num_of_dummy_questions']
    RANDOMIZE = Application.app_config['randomize']

    version 'v1', :using => :path

    helpers do

      def authenticate!
        error!('401 Unauthorized', 401) unless App.find_by_api_token(params[:api_token])
      end

    end

    resource 'quizzes' do

      desc "List all available quizzes"
      get "/" do
        authenticate!
        present Quiz.all, :with => Quiz::CollectionEntity
      end

      desc "Get a specific quiz"
      get "/:id" do
        begin
          authenticate!
          present QuizBuilder.build(Quiz.find(params['id']), DUMMY_QUESTIONS, RANDOMIZE)
        rescue Exception => e
          puts "Error: #{e.message}"
        end
      end

    end

    resource 'challenges' do

      desc "Post a challenge to the server with the user answers"
      post "/create" do
        authenticate!
        challenge = Challenge.new(params['challenge'])
        #challenge.app_id = App.find_by_api_token(params[:api_token]).id
        begin
          challenge.save!
          present challenge
        rescue Exception => e
          puts e.message
        end

      end

      desc "Post a confirmation back to the server, to that the assigned label is correct.
      This sets the flag 'training_record' to true. Use it if your intenttion is to use this record later
      to train your model"
      post "/" do
        authenticate!
        challenge = Challenge.find(params['uuid'])
        challenge.training_record = true
        challenge.save!
      end

    end

  end

  class APIServer < Goliath::API

    def response(env)
      API.call(env)
    end

  end
end
