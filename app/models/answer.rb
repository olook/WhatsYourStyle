module WhatsYourStyle
  class Answer < ActiveRecord::Base
    
    attr_accessible :image, :text, :question_id

    belongs_to :question

    IMAGES_PATH = Application.app_config['images_path']

    def image
      self[:image] = "#{IMAGES_PATH}/#{self[:image]}"
    end

    class Entity < Grape::Entity
      expose :id, :image, :text
    end

  end
end