module Mozart
  class Composite
    def initialize
      @parts = []
    end

    def <<(part)
      parts << part
    end

    def receives?(message)
      !!reciever(message)
    end

    def dispatch(message)
      target = reciever(message) 

      raise NotImplementedError unless target
      
      target.public_send(message)
    end

    private

    def reciever(message)
      parts.find { |part| part.respond_to?(message) } 
    end

    attr_reader :parts
  end
end
