module Hypixel

    class Session

        attr_reader :json, :gameType, :id, :players, :server

        # Constructs a Session instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Session.new json['session']
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @gameType = GameType.from_string json['gameType']
            @id = json['id']
            @players = json['players'] ||= []
            @server = json['server']
        end
    end
end
