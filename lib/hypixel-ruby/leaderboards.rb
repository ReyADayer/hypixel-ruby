module Hypixel

  class Leaderboards

    attr_reader :json, :sections

    def self.from_json(json)
      Leaderboards.new(json['leaderboards'])
    end

    private

    def initialize(json)
      @json = json
      @sections = {}

      json.keys.each do |key|
        game_type = GameType.from_string key

        unless @sections.has_key? game_type
          @sections[game_type] = []
        end

        json[key].keys.each do |section|
          @sections[game_type] << LeaderboardSection.new(json[key][section])
        end
      end
    end
  end

  class LeaderboardSection

    attr_reader :json, :places, :title, :places, :field

    def self.from_json(json)
      LeaderboardSection.new(json)
    end

    private

    def initialize(json)
      @json = json
      @places = json['count']
      @title = json['prefix'] + ' ' + json['title']
      @places = json['leaders']
      @field = json['path']
    end
  end
end
