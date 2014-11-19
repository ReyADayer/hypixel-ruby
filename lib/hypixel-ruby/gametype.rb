module Hypixel

    class GameType

        # Converts the string version into the Ruby symbol.
        #
        # Params:
        # +string+::The JSON string to convert.
        def self.from_string(string)
            case string
            when 'SURVIVAL_GAMES'
                return :Blitz
            when 'QUAKECRAFT'
                return :Quake
            when 'ARCADE'
                return :Arcade
            when 'MCGO'
                return :CaC
            when 'PAINTBALL'
                return :Paintball
            when 'ARENA'
                return :Arena
            when 'TNTGAMES'
                return :TNTGames
            when 'VAMPIREZ'
                return :VampireZ
            when 'WALLS'
                return :Walls
            when 'WALLS3'
                return :MegaWalls
            end
        end
    end
end
