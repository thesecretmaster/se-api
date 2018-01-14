module SE
  module API
    class Post
      attr_reader :body, :title, :link, :author, :score, :type, :id, :last_activity_date, :created_at, :updated_at
      attr_reader :json

      def initialize(item_json)
        @json = item_json
        @body = @json["body"]
        @title = @json["title"]
        @link = @json["link"]
        @score = @json["score"].to_i
        @type = @json["post_type"]
        @id = (@json["post_id"] || @json["answer_id"] || @json["question_id"]).to_i
        @updated_at = @json["last_activity_date"]
        @created_at = @json["creation_date"]
        @last_activity_date = @updated_at
        # @author = User.new(item_json["author"])
      end
    end
  end
end
