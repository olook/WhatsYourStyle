# J48 is a C45 Weka's implementation
module WhatsYourStyle
  module Weka
    class J48 < Classifier

      MODEL = 'j48.model'

      java_import 'weka.classifiers.trees.J48'
      
    end
  end
end