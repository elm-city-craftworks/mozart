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

    private

    attr_reader :parts
  end
end
