module WhatsYourStyle
  class Quiz < ActiveRecord::Base
    
    attr_accessible :name, :description
    has_many :questions, :conditions => {:dummy => false}

    def randomize!
      self.questions.shuffle!
      self.questions.each {|q| q.answers.shuffle! }
    end

    class Entity < Grape::Entity
      expose :name, :description 
      expose :questions, :using => Question::Entity

    end

    class CollectionEntity < Grape::Entity
      expose :name, :description
    end

  end
end