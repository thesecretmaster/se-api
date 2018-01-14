module SE
  module API
    class Post
      attr_reader :body, :title, :link, :author, :score, :type, :id, :last_activity_date, :created_at, :updated_at
      attr_reader :json

      def initialize(item_json)
        @json = item_json
        @body = item_json["body"]
        @title = item_json["title"]
        @link = item_json["link"]
        @score = item_json["score"].to_i
        @type = item_json["post_type"]
        @id = item_json["id"].to_i
        @updated_at = item_json["last_activity_date"]
        @created_at = item_json["creation_date"]
        @last_activity_date = @updated_at
        # @author = User.new(item_json["author"])
      end
    end
  end
end
