module StatHolder

    class Blitz < Generic

        attr_reader :wins, :kills, :deaths

        def initialize(json)
            super json, 'HungerGames'

            @wins = Util.ensure @json['wins'], 0
            @kills = Util.ensure @json['kills'], 0
            @deaths = Util.ensure @json['deaths'], 0
        end

        def kit_level(kit)
            kit.downcase!

            Util.ensure @json[kit], 0
        end
    end
end
