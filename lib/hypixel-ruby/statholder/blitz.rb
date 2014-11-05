module StatHolder

    class Blitz < Generic

        attr_reader :wins, :kills, :deaths

        def initialize(json)
            super json, 'HungerGames'

            @wins = @json['wins'] ||= 0
            @kills = @json['kills'] ||= 0
            @deaths = @json['deaths'] ||= 0
        end

        # Returns the Kit's level.
        #
        # Params:
        # +kit+::The name of the Kit. Case-insensitive.
        def kit_level(kit)
            @json[kit.downcase] ||= 0
        end
    end
end
