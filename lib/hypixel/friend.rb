module Hypixel

    class Friend

        attr_reader :username, :since

        def initialize(username, since)
            @username = username
            @since = since
        end
    end
end
