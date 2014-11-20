module Hypixel

    class Player

        attr_reader :json, :username, :uuid, :stats

        # Constructs a Player instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Player.new json['player']
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @username = json['playername']
            @uuid = json['uuid']
            @stats = Stats.from_json json
        end
    end
end
