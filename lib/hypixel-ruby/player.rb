module Hypixel

    class Player

        attr_reader :username, :uuid

        def self.from_json(json)
            Player.new json['playername'], json['uuid']
        end

        def initialize(username, uuid)
            @username = username
            @uuid = uuid
        end
    end
end
