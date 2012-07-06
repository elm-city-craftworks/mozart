module Mozart
  module SingleAssignment
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
  end
end
