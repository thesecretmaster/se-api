module SE
  module API
    class Question < Post
      attr_reader :answers
      
      def initialize(item_json)
        super(item_json)
        @answers = item_json["answers"].map { |i| Answer.new(i) }
      end
    end
  end
end