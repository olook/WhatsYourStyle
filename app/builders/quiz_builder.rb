module WhatsYourStyle
  class QuizBuilder

    class << self

      def build(quiz, num_dummy, randomize=true)
        quiz.questions << add_dummy_questions(num_dummy)
        quiz.randomize! if randomize
        quiz
      end

      private

      def add_dummy_questions(num)
        Question.dummy.shuffle.take(num)
      end

    end

  end
end