module StatHolder

    class Generic

        attr_reader :packages, :coins

        def initialize(json, name)
            json = json['stats'][name]

            @packages = json['packages'] ||= []
            @coins = json['coins'] ||= 0
        end
    end
end
