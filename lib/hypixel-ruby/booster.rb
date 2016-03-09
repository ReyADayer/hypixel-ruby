module Hypixel

  class Booster

    attr_reader :json, :purchaser, :multiplier, :activated, :duration, :remaining_duration, :game_type

    def self.from_json(json)
      Booster.new(json)
    end

    private

    def initialize(json)
      @json = json
      @purchaser = json['purchaser']
      @multiplier = json['amount']
      @activated = Time.at(json['dateActivated'] / 1000)
      @duration = json['originalLength']
      @remaining_duration = json['length']
      @game_type = GameType.from_id json['gameType']
    end
  end
end
