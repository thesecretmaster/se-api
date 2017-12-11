module SE
  module API
    class Post
      attr_reader :body, :title, :link, :author, :score, :type
      attr_reader :json

      def initialize(item_json)
        @json = item_json
        @body = item_json["body"]
        @title = item_json["title"]
        @link = item_json["link"]
        @score = item_json["score"]
        @type = item_json["post_type"]
        # @author = User.new(item_json["author"])
      end
    end
  end
end
