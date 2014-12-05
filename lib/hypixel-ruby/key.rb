module Hypixel

    class Key

        attr_reader :json, :owner, :queriesPerMinute, :totalQueries

        # Constructs a Key instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Key.new json['record']
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @owner = json['owner']
            @queriesPerMinute = json['queriesInPastMin']
            @totalQueries = json['totalQueries']
        end
    end
end
