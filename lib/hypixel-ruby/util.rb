class Util

    class << self

        def ensure(input, default)
            if input == nil
                input = default
            end

            input
        end
    end
end
