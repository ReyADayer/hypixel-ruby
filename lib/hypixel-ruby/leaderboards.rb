module Hypixel

    class Leaderboards

        attr_reader :json, :sections

        # Constructs a Leaderboards instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            Leaderboards.new json['leaderboards']
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @sections = {}

            json.keys.each do | key |
                gameType = GameType.from_string key

                unless @sections.has_key? gameType
                    @sections[gameType] = []
                end

                json[key].keys.each do | section |
                    @sections[gameType] << LeaderboardSection.new(json[key][section])
                end
            end
        end
    end

    class LeaderboardSection

        attr_reader :json, :places, :title, :places, :field

        # Constructs a LeaderboardSection instance using the JSON object.
        # Wraps the initialize method for future changes.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def self.from_json(json)
            LeaderboardSection.new json
        end

        private

        # Offloads the JSON object's values to the local instance.
        #
        # Params:
        # +json+::The JSON object to construct from.
        def initialize(json)
            @json = json
            @places = json['count']
            @title = json['prefix'] + " " + json['title']
            @places = json['leaders']
            @field = json['path']
        end
    end
end
