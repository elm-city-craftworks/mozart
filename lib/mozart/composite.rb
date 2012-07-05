module Mozart
  class Composite
    def initialize
      @parts = []
    end

    def <<(part)
      parts << part
    end

    def receives?(message)
      parts.any? { |part| part.respond_to?(message) }
    end

    def dispatch(message)
      parts.find { |part| part.respond_to?(message) }
           .public_send(message)
    end

    private

    attr_reader :parts
  end
end
