require 'bundler'
Bundler.require
#require 'json/pure'
require './application'

module WhatsYourStyle

  autoload :DatabaseConnectable, 'app/database_connectable'
  autoload :App, 'app/models/app'
  autoload :Quiz, 'app/models/quiz'
  autoload :Question, 'app/models/question'
  autoload :Answer, 'app/models/answer'
  autoload :Challenge, 'app/models/challenge'
  autoload :ChallengeCalculator, 'app/challenge_calculator'
  autoload :QuizBuilder, 'app/builders/quiz_builder'

  module Weka
    require 'java'
    $CLASSPATH << Application.root + '/app/classification/lib'

    autoload :DataBuilder, 'app/classification/data_builder'
    autoload :Classifier, 'app/classification/classifier'
    autoload :J48,  'app/classification/j48'
    autoload :NaiveBayes, 'app/classification/naive_bayes'
  end

end
