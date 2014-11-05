module Hypixel

    class Friend

        attr_reader :username, :since

        def self.from_json(json)
            Friend.new json
        end

        private

        def initialize(json)
            @username = json['receiver']
            @since = Time.at json['started'] / 1000
        end
    end
end
