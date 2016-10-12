module Number

  class Number
    def succ
      NonZero.new(self)
    end
  end

  class Zero < Number
  end

  class NonZero < Number
    def initialize(pred)
      @pred = pred
    end
  end

end
