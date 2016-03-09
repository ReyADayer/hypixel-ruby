module Hypixel

  class GameType

    # Returns the symbol for the matching GameType.
    #
    # Params:
    # +string+::The technical name returned by the API.
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
        when 'UHC'
          return :UHC
      end
    end

    # Returns the symbol for the matching GameType.
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
        when 20
          return :UHC
        when 21
          return :CaC
      end
    end

    # Returns the clean name for the matching GameType.
    #
    # Params:
    # +symbol+::The symbol.
    # +short_hand+::If true, returns the shortened version of the name.
    def self.from_symbol(symbol, short_hand = false)
      if short_hand
        case symbol
          when :Quakecraft
            return 'Quake'
          when :Walls, :Arcade, :Arena, :CaC, :UHC
            return symbol.to_s
          when :TNTGames
            return 'TNT'
          when :Paintball
            return 'PB'
          when :VampireZ
            return 'VZ'
          when :Blitz
            return 'BSG'
          when :MegaWalls
            return 'MW'
        end
      end

      case symbol
        when :Quakecraft, :Walls, :Paintball, :TNTGames, :VampireZ, :Arcade, :UHC
          return symbol.to_s
        when :Blitz
          return 'Blitz SG'
        when :MegaWalls
          return 'Mega Walls'
        when :Arena
          return 'Arena Brawl'
        when :CaC
          return 'Cops and Crims'
      end
    end

    # Returns the symbol for the matching GameType.
    #
    # Params:
    # +name+::The database name used in the API.
    def self.from_db_name(name)
      case name
        when 'Quake'
          return :Quakecraft
        when 'Walls', 'Paintball', 'TNTGames', 'VampireZ', 'Arcade', 'Arena', 'UHC'
          return name.to_sym
        when 'HungerGames'
          return :Blitz
        when 'Walls3'
          return :MegaWalls
        when 'MCGO'
          return :CaC
      end
    end
  end
end
