module Mozart
  AmbiguousMessageError = Class.new(StandardError)

  class Composite
    def initialize
      self.parts = []
    end

    def <<(part)
      parts << part
    end

    def receives?(message)
      !!recipient(message)
    end

    def dispatch(message, *a, &b)
      target = recipient(message)
      
      raise NotImplementedError unless target

      target.public_send(message, *a, &b)
    end

    def recipient(message)
      target, *rest = parts.select { |part| part.respond_to?(message) }

      raise AmbiguousMessageError unless rest.empty?

      target
    end
 
    private

    attr_accessor :parts
  end
end
