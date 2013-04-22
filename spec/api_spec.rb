require 'spec_helper'
require 'ruby-debug'

module WhatsYourStyle
  describe API do

    def app 
      API 
    end

    context "when not authorized" do

      context "and trying to access quizzes" do

        it "should deny access to the list of quizzes" do
          get "/v1/quizzes"
          last_response.status.should == 401
        end

        it "should deny access to get a quiz" do
          get "/v1/quizzes/1"
          last_response.status.should == 401
        end

      end

      context "and trying to access challenges" do

        it "should deny access to create challenges" do
          post "/v1/challenges/create"
          last_response.status.should == 401
        end

        it "should deny access to set a training record" do
          post "/v1/challenges/"
          last_response.status.should == 401
        end

      end

    end


    context "when authorized" do

      before(:all) do
        @app = App.create(:api_token => "abcdefghijk", :name => "Olook")

        @quiz = Quiz.create(:name => "Whats your style?", :description => "A quiz to discover Olook's customers style")

        csv = CSV.read(File.dirname(__FILE__) + '/fixtures/questions.csv', {:headers => true, :header_converters => :symbol , 
        :col_sep => ","}) 
        csv.each do |row|
          q = Question.new(:text => row[:text], :id => row[:id], :quiz_id => @quiz.id, :dummy => row[:dummy])
          q.save!
        end

        csv1 = CSV.read(File.dirname(__FILE__) + '/fixtures/answers.csv', {:headers => true,  
          :header_converters => :symbol , :col_sep => ","}) 
        csv1.each do |row|
          q1 = Answer.create(:text => row[:text], :image => row[:image], 
          :question_id => Question.find(row[:question_id]).id)
        end
      end

      it "should list all available quizzes" do
        response = load_fixture("quizzes")
        get "/v1/quizzes?api_token=#{@app.api_token}"
        last_response.body.should == response
      end

      context "a specific quiz" do

        before(:all) do
          @cls_questions = Question.find_all_by_dummy(false)
          get "/v1/quizzes/#{@quiz.id}?api_token=#{@app.api_token}"; @response = last_response.body
        end

        it "the total number of questions should be represented by dummy and all non-dummy questions" do
          @response.should have_json_size(@cls_questions.size + Application.app_config['num_of_dummy_questions']).at_path("questions")
        end     

        context "classification questions" do
          
          it "should have a text and id" do
            @cls_questions.each do |q|
              @response.should include(q.text)
              @response.should include(q.id.to_s)
            end
          end

          it "should have answer with id, text and image" do
            @cls_questions.each do |q|
              q.answers.each do |a|
                @response.should include(a.text)
                @response.should include(a.id.to_s)
                @response.should include (a.image)
              end
            end
          end

        end
      end

      context "and trying to access challenges" do
        it "should accept a map of questions and answers" do
          get "/v1/challenges?api_token=#{@app.api_token}"
          pending
        end

        it "should reply with a classification label and an uuid" do
          get "/v1/challenges?api_token=#{@app.api_token}"
          pending
        end

      end

    end

  end
end
