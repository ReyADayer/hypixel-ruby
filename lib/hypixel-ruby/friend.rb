module Hypixel

    class Friend

        attr_reader :username, :since

        def self.from_json(json)
            Friend.new json['receiver'], Time.at(json['started'] / 1000)
        end

        def initialize(username, since)
            @username = username
            @since = since
        end
    end
end
