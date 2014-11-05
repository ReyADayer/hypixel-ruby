module Hypixel

    class Friend

        attr_reader :username, :since

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
            @username = json['receiver']
            @since = Time.at json['started'] / 1000
        end

        public

        # Creates a JSON object that follows the same format as needed to create an instance.
        # As such, it also matches the output of the API's requests.
        def to_json
            ({
                :receiver => @username,
                :since => @since.to_i * 1000
            }).to_json
        end
    end
end
