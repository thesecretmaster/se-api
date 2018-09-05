module SE
  module API
    class Tag
      attr_reader :json, :count, :synonyms, :name

      def initialize(item_json)
        @json = Hash(item_json)
        @count = @json['count'].to_i
        @synonyms = Array(@json['synonyms'])
        @name = @json['name']
      end
    end
  end
end
