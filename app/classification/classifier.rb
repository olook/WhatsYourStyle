module WhatsYourStyle
  module Weka
    class Classifier

      java_import 'weka.core.SerializationHelper'

      attr_reader :result, :fmeasure

      def initialize(algorithm)
        @algorithm = load_model(algorithm)
      end

      def classify(data)
        idx = @algorithm.classify_instance data.instance
        data.data_set.class_attribute.value(idx)
      end

      private

      def load_model(algorithm)
        SerializationHelper.read(WhatsYourStyle::Application.weka_root+"/data/#{algorithm}").to_java Java::WekaClassifiers::Classifier
      end

    end
  end
end