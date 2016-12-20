module Hypixel

  class Stats

    attr_reader :packages, :coins, :json, :fields

    def self.from_json(json)
      Stats.new(json['stats'] ||= {})
    end

    private

    def initialize(json)
      @packages = {}
      @coins = {}
      @json = {}
      @fields = {}

      json.keys.each do |key|
        game_type = GameType.from_db_name key

        @packages[game_type] = json[key]['packages'] ||= []
        @coins[game_type] = json[key]['coins'] ||= 0
        @json[game_type] = json[key]
        @fields[game_type] = {}

        json[key].each do |key, value|
          @fields[game_type][key] = value
        end
      end
    end
  end
end
