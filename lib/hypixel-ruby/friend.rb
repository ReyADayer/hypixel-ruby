module Hypixel

    class Friend

        attr_reader :json, :username, :since

        # Constructs a Friend instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Friend.new json
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @username = json['receiver']
            @since = Time.at json['started'] / 1000
        end
    end
end
