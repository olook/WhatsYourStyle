# -*- encoding : utf-8 -*-
module WhatsYourStyle
  class Challenge < ActiveRecord::Base
    
    attr_accessible :answers, :classification_label, :uuid, :training_record
    belongs_to :app

    #before_save :convert_to_integer_key

    after_find :sort_and_remove_dummy

    serialize :answers, Hash

    self.primary_key = "uuid"

    before_save ChallengeCalculator.new

    def to_s
      Hash[self.answers.map { |q,a| [Question.find(q).text, Answer.find(a).text]}]
    end

    private

    def sort_and_remove_dummy
      sort
      remove_dummy
    end

    def sort
      self.answers = Hash[self.answers.sort_by {|q,a| q }]
    end

    def remove_dummy
      self.answers.keep_if {|k,v| !Question.find(k).dummy}
    end

    class Entity < Grape::Entity
      expose :uuid
      expose :classification_label
    end

  end
end