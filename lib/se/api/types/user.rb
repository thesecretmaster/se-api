module SE
  module API
    class User
      attr_reader :json, :accept_rate, :badge_counts, :name, :link, :image, :reputation, :id, :type

      def initialize(item_json)
        @json = Hash(item_json)
        @accept_rate = @json["accept_rate"]
        @badge_counts = @json["badge_counts"]
        @name = @json["display_name"]
        @link = @json["link"]
        @image = @json["profile_image"]
        @reputation = @json["reputation"]
        @id = @json["user_id"]
        @type = @json["user_type"]
      end
    end
  end
end