module Hypixel

    class Guild

        attr_reader :id, :name, :tag, :motd, :members, :created

        def initialize(id, name, tag, motd, members, created)
            @id = id
            @name = name
            @tag = tag
            @motd = motd
            @members = members
            @created = created
        end
    end

    class GuildMember

        attr_reader :username, :rank, :joined

        def initialize(username, rank, joined)
            @username = username
            @rank = rank
            @joined = joined
        end
    end
end
