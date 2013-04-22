module WhatsYourStyle
  class ChallengeCalculator

    def before_save(record)
      data = Weka::DataBuilder.new.build(record.answers)
      cls = Weka::Classifier.new(Weka::J48::MODEL)
      record.classification_label = cls.classify(data)
      record.uuid = UUID.generate
    end

  end
end