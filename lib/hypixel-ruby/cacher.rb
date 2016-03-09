module Hypixel

  class Cacher

    attr_accessor :enabled, :maxCount, :storage

    def initialize
      @enabled = false
      @maxCount = 5
      @storage = {}

      @storage[:guild] = {}
      @storage[:friend] = {}
      @storage[:player] = {}
      @storage[:session] = {}
    end

    def put(type, key, value)
      if @storage[type].size >= @maxCount
        @storage[type].shift
      end

      @storage[type][key] = value

      value
    end

    def has?(type, key)
      @storage.has_key?(type) && @storage[type].has_key?(key)
    end

    def get(type, key)
      @storage[type][key]
    end
  end
end
