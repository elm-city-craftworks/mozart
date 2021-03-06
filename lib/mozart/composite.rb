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
      
      unless target
        raise NotImplementedError, "No recipient implements #{message}" 
      end

      target.public_send(message, *a, &b)
    end

    private

    def recipient(message)
      target, *rest = parts.select { |part| part.respond_to?(message) }

      raise AmbiguousMessageError unless rest.empty?

      target
    end

    attr_accessor :parts
  end
end
