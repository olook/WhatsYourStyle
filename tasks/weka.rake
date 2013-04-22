# author: Felipe Jordão A.P. Mattosinho
# EXPERTTE Turning data into knowledge

# -*- encoding: utf-8 -*-
require 'csv'

namespace :weka do

  # Harvest the database for training files and create an arff file which can be used
  # to build models in Weka

  desc "Export results to an arff file. Arff file is the prefered format used by Weka"
  task :create_arff_training_file => :environment do
    
    File.open(File.dirname(__FILE__) + '/results.arff', "w+") do |f|
      f.puts "@RELATION fashion_style"
      f.puts ""

      Question.all.each do |q|
        f.puts "@ATTRIBUTE '#{q.title}' {#{q.answers.collect {|a| "'"+a.name.gsub("'","")+"'"}.join(',')}}"
      end

      f.puts "@ATTRIBUTE fashion_style {'fashion', 'casual/romantica', 'sexy', 'elegante'}"
      f.puts ""
      f.puts "@DATA"

      SurveyChallenge.all.each do |sc|
        f.puts "#{sc.question_answer_map_to_ordered_answers.join(',')},#{sc.classification_label}"
      end

    end


  end

  desc "Train model"
  task :train_model => :environment do


  end

  desc "Test model"
  task :test_model => :environment do


  end

  desc "Sum with seed data"
  
end