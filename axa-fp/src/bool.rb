module Bool

  class True
    def or(other)
      self
    end
    def and(other)
      other
    end
  end

  class False
    def or(other)
      other
    end
    def and(other)
      self
    end
  end

end
