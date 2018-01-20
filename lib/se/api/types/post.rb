require "se/api/types/user"

module SE
  module API
    class Post
      attr_reader :body, :title, :link, :author, :score, :type, :id, :last_activity_date, :created_at, :updated_at, :last_editor, :comments
      attr_reader :json

      def initialize(item_json)
        @json = Hash(item_json)
        @body = @json["body"]
        @title = @json["title"]
        @link = @json["link"]
        @score = @json["score"].to_i
        @type = @json["post_type"]
        @last_editor = User.new(@json["last_editor"])
        @comments = @json["comments"].map { |c| Comment.new(c) }
        @id = (@json["post_id"] || @json["answer_id"] || @json["question_id"]).to_i
        @updated_at = @json["last_activity_date"]
        @created_at = @json["creation_date"]
        @author = User.new(@json["owner"])
      end

      alias_method :last_activity_date, :updated_at
      alias_method :user, :author
      alias_method :owner, :author
    end
  end
end
