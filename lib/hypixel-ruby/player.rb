module Hypixel

    class Player

        attr_reader :json, :username, :uuid, :statHolders

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
            @statHolders = Hash.new

            @statHolders[:Arcade] = StatHolder::Generic.new json, 'Arcade'
            @statHolders[:Arena] = StatHolder::Generic.new json, 'Arena'
            @statHolders[:CaC] = StatHolder::Generic.new json, 'MCGO'
            @statHolders[:Paintball] = StatHolder::Generic.new json, 'Paintball'
            @statHolders[:Quake] = StatHolder::Generic.new json, 'Quake'
            @statHolders[:TNTGames] = StatHolder::Generic.new json, 'TNTGames'
            @statHolders[:VampireZ] = StatHolder::Generic.new json, 'VampireZ'
            @statHolders[:Walls] = StatHolder::Generic.new json, 'Walls'
            @statHolders[:MegaWalls] = StatHolder::Generic.new json, 'Walls3'

            @statHolders[:Blitz] = StatHolder::Blitz.new json
        end
    end
end
