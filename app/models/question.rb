module WhatsYourStyle
  class Question < ActiveRecord::Base
    
    self.primary_key = "id" 

    attr_accessible :quiz_id, :text, :id, :dummy

    has_many :answers
    belongs_to :quiz

    scope :dummy, where('dummy = ?', true)
    scope :classification, where('dummy = ?', false)


    class Entity < Grape::Entity
      expose :id
      expose :text
      expose :answers, :using => Answer::Entity
    end
  end

end