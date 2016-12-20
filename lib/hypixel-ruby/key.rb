module Hypixel

  class Key

    attr_reader :json, :owner, :queries_per_m, :total_queries

    def self.from_json(json)
      Key.new(json['record'])
    end

    private

    def initialize(json)
      @json = json
      @owner = json['owner']
      @queries_per_m = json['queriesInPastMin']
      @total_queries = json['totalQueries']
    end
  end
end
