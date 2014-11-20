module Hypixel

    class GameType

        # Returns the Ruby symbol for the matching GameType.
        #
        # Params:
        # +string+::The technical name.
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

        # Returns the Ruby symbol for the matching GameType.
        #
        # Params:
        # +id+::The numerical id.
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

        # Returns the clean name for the matching GameType.
        #
        # Params:
        # +symbol+::The Ruby symbol.
        def self.from_symbol(symbol)
            case symbol
            when :Quakecraft, :Walls, :Paintball, :TNTGames, :VampireZ, :Arcade
                return symbol.to_s
            when :Blitz
                return 'Blitz SG'
            when :MegaWalls
                return 'Mega Walls'
            when :Arena
                return 'Arena Brawl'
            when :Cac
                return 'Cops and Crims'
            end
        end

        # Returns the Ruby symbol for the matching GameType.
        #
        # Params:
        # +name+::The database/storage name.
        def self.from_db_name(name)
            case name
            when 'Quake'
                return :Quakecraft
            when 'Walls'
                return :Walls
            when 'Paintball'
                return :Paintball
            when 'HungerGames'
                return :Blitz
            when 'TNTGames'
                return :TNTGames
            when 'VampireZ'
                return :VampireZ
            when 'Walls3'
                return :MegaWalls
            when 'Arcade'
                return :Arcade
            when 'Arena'
                return :Arena
            when 'MCGO'
                return :CaC
            end
        end
    end
end
