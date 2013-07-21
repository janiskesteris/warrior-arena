class Combat

  def initialize attacker, defender
    @attacker = attacker
    @defender = defender
  end

  def fight
    while both_alive?
      @attacker.attacks(@defender)
      puts "#{@attacker.name_and_health} killed #{@defender.name_and_health}".red if @defender.dead?
      sleep(@attacker.attack_speed)
    end
  end

  def both_alive?
    @attacker.alive? && @defender.alive?
  end

end