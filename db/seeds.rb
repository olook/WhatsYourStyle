require 'csv'
require 'active_record'

module WhatsYourStyle

  quiz = Quiz.create(:name => "Whats your style?", :description => "A quiz to discover Olook's customers style")

  csv = CSV.read(File.dirname(__FILE__) + '/fixtures/questions_rank_attribute_selection.csv', {:headers => true,  
    :header_converters => :symbol , :col_sep => ","})
  csv.each do |row|
    q = Question.new(:text => row[:text], :id => row[:id], :quiz_id => quiz.id, :dummy => row[:dummy])
    q.save!
  end

  csv1 = CSV.read(File.dirname(__FILE__) + '/fixtures/answers.csv', {:headers => true,  
    :header_converters => :symbol , :col_sep => ","})
  csv1.each do |row|
    q1 = Answer.create(:text => row[:text], :image => row[:image], 
    :question_id => Question.find(row[:question_id]).id)
  end

  csv3 = CSV.read(File.dirname(__FILE__) + '/fixtures/training_challenges.csv', {:headers => true,  
    :header_converters => :symbol , :col_sep => ","})
  csv3.each do |row|
    answers = YAML::load(row[:answers])
    answers = Hash[answers.map{|q,a| [q.to_i,a.to_i]}]
    q3 = Challenge.new(:uuid => UUID.generate, :answers => answers, :classification_label => 
    row[:classification_label], training_record: true)
    q3.save
  end

end

