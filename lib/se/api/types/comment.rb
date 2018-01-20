require "se/api/types/user"

module SE
  module API
    class Comment
      attr_reader :body, :link, :id, :post_id, :score, :type, :created_at, :author, :body_markdown
      attr_reader :json

      def initialize(item_json)
        @json = item_json
        @body = item_json["body"]
        @body_markdown = item_json["body_markdown"]
        @link = item_json["link"]
        @post_id = item_json["post_id"].to_i
        @score = item_json["score"].to_i
        @type = item_json["post_type"]
        @id = item_json["comment_id"].to_i
        @created_at = item_json["creation_date"]
        @author = User.new(item_json["owner"])
      end

      alias_method :user, :author
      alias_method :owner, :author
    end
  end
end
