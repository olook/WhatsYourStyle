module WhatsYourStyle
  module Weka
    class DataBuilder

      java_import 'weka.core.Attribute'
      java_import 'weka.core.Instance'
      java_import 'weka.core.Instances'
      java_import 'weka.core.FastVector'

      CLASSIFICATION_LABELS = ["fashion", "casual/romantica", "sexy", "elegante"]

      NUM_OF_ATTRIBUTES = 10

      attr_reader :attributes, :data_set, :instance

      def build(data)
        build_instance(data)
        self
      end

      def build_data_set
        add_attributes
        add_classification_labels
        @data_set = Instances.new("fashion_style", @attributes, 0)
        @data_set.setClassIndex(data_set.numAttributes() - 1)
      end

      def build_instance(data)
        build_data_set
        @instance = Instance.new(NUM_OF_ATTRIBUTES)
        data.each do |q,a|
          q = Question.find(q)
          unless q.dummy
            attribute = @data_set.attribute(q.text) 
            @instance.set_value(attribute, Answer.find(a).text)
          end
        end
        @instance.set_dataset(@data_set)
        @instance
      end

      private

      def add_attributes
        @attributes = FastVector.new
        Question.classification.each do |q|
          values = FastVector.new(4)
            q.answers.each do |a|
              values.addElement(a.text)
            end
          @attributes.add_element(Attribute.new(q.text, values))
        end
      end

      def add_classification_labels
        class_values = FastVector.new(4)
        CLASSIFICATION_LABELS.each do |cl|
          class_values.add_element(cl)
        end
        @attributes.add_element(Attribute.new("fashion_style", class_values))
      end


    end
  end
end