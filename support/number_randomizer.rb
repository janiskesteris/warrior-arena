class NumberRandomizer
  def initialize number, percent
    @number = number
    @percent = percent
  end

  def randomized_number
    @number.send(addition_or_subtraction, randomizer)
  end

  private

  def randomizer
    value_from_percent != 0 ? Kernel.rand(value_from_percent) : 0
  end

  def value_from_percent
    @percent.percent_of(@number)
  end

  def addition_or_subtraction
    [:+, :-].sample
  end

end