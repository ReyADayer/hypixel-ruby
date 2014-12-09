module Hypixel

    class Cacher

        attr_accessor :maxCount, :enabled

        # Constructs a Cacher instance.
        #
        # A default of 10 is applied to the maxCount.
        # The Cacher is also not enabled by default.
        def initialize
            @enabled = false
            @maxCount = 10
            @holder = {}
        end

        # Manually clears the cache.
        def clear
            @holder.clear
        end

        # Stores the value into the cache using the specified key.
        # If the cache size surpasses the maxCount, it will be cleared before it is inserted.
        #
        # Params:
        # +key+::The unique key for the value.
        # +value+::The value that should be returned when queried.
        def store(key, value)
            unless @enabled then return value end

            if @holder.size >= @maxCount
                @holder.clear
            end

            @holder[key] = value

            value
        end

        # Used to check if we have a cached value with the specified key.
        def has?(key)
            unless @enabled then return false end

            @holder.has_key? key
        end

        # Returns the cached value with the matching key.
        def get(key)
            @holder[key]
        end
    end
end
