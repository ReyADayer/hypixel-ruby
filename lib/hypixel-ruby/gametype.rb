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

        # Converts the numerical id into the Ruby symbol.
        #
        # Params:
        # +id+::The numerical id to convert.
        def self.from_id(id)
            case id
            when 2
                return :Quakecraft
            when 3
                return :Walls
            when 4
                return :Paintball
            when 5
                return :Blitz
            when 6
                return :TNTGames
            when 7
                return :VampireZ
            when 13
                return :MegaWalls
            when 14
                return :Arcade
            when 17
                return :Arena
            when 21
                return :CaC
            end
        end

        # Converts the Ruby symbol into the clean name.
        #
        # Params:
        # +symbol+::The Ruby symbol to convert.
        def self.name(symbol)
            case symbol
            when :Quakecraft
                return 'Quakecraft'
            when :Walls
                return 'Walls'
            when :Paintball
                return 'Paintball'
            when :Blitz
                return 'Blitz SG'
            when :TNTGames
                return 'TNTGames'
            when :VampireZ
                return 'VampireZ'
            when :MegaWalls
                return 'Mega Walls'
            when :Arcade
                return 'Arcade'
            when :Arena
                return 'Arena Brawl'
            when :Cac
                return 'Cops and Crims'
            end
        end
    end
end
