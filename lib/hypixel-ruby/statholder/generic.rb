module StatHolder

    class Generic

        def initialize(json, name)
            @json = json['stats'][name]
        end

        def coins
            @json['coins']
        end
    end
end
