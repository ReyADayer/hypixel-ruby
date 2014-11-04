module Hypixel

    class Player

        attr_reader :username, :uuid, :statHolders

        def self.from_json(json)
            json = json['player']
            statHolders = Hash.new

            statHolders[:blitz] = StatHolder::Generic.new json, 'HungerGames'
            statHolders[:arcade] = StatHolder::Generic.new json, 'Arcade'
            statHolders[:arena] = StatHolder::Generic.new json, 'Arena'
            statHolders[:cac] = StatHolder::Generic.new json, 'MCGO'
            statHolders[:paintball] = StatHolder::Generic.new json, 'Paintball'
            statHolders[:quake] = StatHolder::Generic.new json, 'Quake'
            statHolders[:tntgames] = StatHolder::Generic.new json, 'TNTGames'
            statHolders[:vampirez] = StatHolder::Generic.new json, 'VampireZ'
            statHolders[:walls] = StatHolder::Generic.new json, 'Walls'
            statHolders[:MegaWalls] = StatHolder::Generic.new json, 'Walls3'

            Player.new json['playername'], json['uuid'], statHolders
        end

        def initialize(username, uuid, statHolders)
            @username = username
            @uuid = uuid
            @statHolders = statHolders
        end
    end
end
