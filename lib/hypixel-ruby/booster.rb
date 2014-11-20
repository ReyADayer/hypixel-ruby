module Hypixel

    class Booster

        attr_reader :json, :purchaser, :multiplier, :activated, :duration, :remainingDuration, :gameType

        # Constructs a Booster instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Booster.new json
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @purchaser = json['purchaser']
            @multiplier = json['amount']
            @activated = Time.at json['dateActivated'] / 1000
            @duration = json['originalLength']
            @remainingDuration = json['length']
            @gameType = GameType.from_id json['gameType']
        end
    end
end
