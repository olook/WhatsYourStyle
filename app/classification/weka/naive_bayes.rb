module WhatsYourStyle
  module Weka
    class NaiveBayes < Classifier

      java_import 'weka.classifiers.bayes.NaiveBayes'

      MODEL_NAME = 'naive_bayes.model'

    end
  end
end