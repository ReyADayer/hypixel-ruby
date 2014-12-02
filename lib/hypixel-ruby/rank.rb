module Hypixel

    class Rank

        # Returns the highest rank provided in the array.
        # Supports both lists of symbols and strings.
        #
        # Params:
        # +ranks+::List of ranks to sort.
        # +symbols+::Whether or not the list provided is raw strings or symbols.
        def self.top(ranks, symbols = true)
            return from_string(ranks.max_by do | rank |
                unless symbols
                    rank = from_string rank
                end

                to_ordinal rank
            end)
        end

        # Returns the symbol for the matching Rank.
        #
        # Params:
        # +id+::The database name returned by the API.
        def self.from_string(string)
            case string
            when 'ADMIN', 'MODERATOR', 'HELPER', 'YOUTUBER'
                return string.capitalize.to_sym
            when 'JR_HELPER'
                return :JrHelper
            when 'VIP', 'MVP'
                return string.to_sym
            when 'VIP_PLUS'
                return :VIPPlus
            when 'MVP_PLUS'
                return :MVPPlus
            end
        end

        private

        # Defines the rank listing and sets up their ordinals.
        # Only ever called internally.
        def self.setup
            unless defined? @ranks
                @ranks = {}

                [:VIP, :VIPPlus, :MVP, :MVPPlus, :JrHelper, :Youtuber, :Helper, :Moderator, :Admin].each do | key |
                    @ranks[key] = @ranks.size
                end
            end
        end

        # Returns the matching symbol for the ordinal.
        #
        # Params:
        # +ordinal+::The ordinal of the rank.
        def self.from_ordinal(ordinal)
            setup

            return nil unless @ranks.has_value? ordinal

            @ranks.key ordinal
        end

        # Returns the matching ordinal for the symbol.
        #
        # Params:
        # +rank+::The rank's symbol.
        def self.to_ordinal(rank)
            setup

            return -1 unless @ranks.has_key? rank

            @ranks[rank]
        end
    end
end
