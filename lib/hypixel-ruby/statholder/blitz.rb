module StatHolder

    class Blitz

        def initialize(json)
            @json = json['stats']['HungerGames']
        end

        def coins
            @json['coins']
        end
    end
end
