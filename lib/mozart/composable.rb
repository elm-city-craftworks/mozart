require_relative "composite"

module Mozart
  module Composable
    private

    def features
      @features ||= Mozart::Composite.new
    end

    def _(*args)
      @__internals__ ||= {}

      case args.count
      when 1
        @__internals__[args.first]
      when 2
        if @__internals__.key?(args.first)
          raise "Single assignment only!"
        else
          @__internals__[args.first] = args.last
        end
      else
        raise ArgumentError
      end
    end

    def respond_to_missing?(m, *a, &b)
      features.receives?(m)
    end

    def method_missing(m, *a, &b)
      return super unless features.receives?(m)

      features.dispatch(m, *a, &b)
    end
  end
end
