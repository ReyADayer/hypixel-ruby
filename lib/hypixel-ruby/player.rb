module Hypixel

    class Player

        attr_reader :username, :uuid, :statHolders

        def self.from_json(json)
            Player.new json['player']
        end

        private

        def initialize(json)
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
