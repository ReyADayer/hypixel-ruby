module StatHolder

    class Generic

        attr_reader :packages, :coins

        def initialize(json, name)
            @json = json['stats'][name]
            
            @packages = Util.ensure @json['packages'], Array.new
            @coins = Util.ensure @json['coins'], 0
        end
    end
end
