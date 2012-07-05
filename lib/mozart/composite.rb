module Mozart
  class Composite
    def <<(part)
    end

    def receives?(message)
      [:foo, :bar].include?(message)
    end
  end
end
