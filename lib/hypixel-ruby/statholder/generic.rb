module StatHolder

    class Generic

        attr_reader :packages, :coins

        # Represents stats for a specific game.
        # Used to provide ease-of-use methods for handling stats.
        #
        # Params:
        # +json+::The JSON object to construct from.
        # +name+::The game's database name to locate the corresponding data in the JSON object.
        def initialize(json, name)
            json = json['stats'][name]

            @packages = json['packages'] ||= []
            @coins = json['coins'] ||= 0
        end
    end
end
