class Warrior
  attr_accessor :name, :health, :armor, :strength, :agility, :luck
  CRITICAL_HIT_PERCENT = 50.0
  CRITICAL_DAMAGE_RANDOMIZER_PERCENT = 20.0
  DAMAGE_RANDOMIZER_PERCENT = 5.0
  STRENGTH_TO_DAMAGE_RATIO = 1.5
  AGILITY_DEFENSE_BONUS_PERCENT = 25.0
  AGILITY_DEFENSE_BONUS_RANDOMIZER_PERCENT = 20.0
  DEFAULT_ATTACK_SPEED = 2.0
  MAX_ATTACK_SPEED = 0.5
  MIN_DAMAGE_RAND = 3

  def initialize(options={})
    @name = options[:name] || "#{Faker::Name.prefix} #{Faker::Name.last_name}"
    @health = options[:health].to_i
    @armor = options[:armor].to_i
    @strength = options[:strength].to_i
    @agility = options[:agility].to_i
    @luck = options[:luck].to_i
  end

  def attack_damage
    critical = critical_hit_damage
    puts "CRITICAL HIT".colorize( :light_blue ) if critical > 0
    NumberRandomizer.new((natural_damage + critical), DAMAGE_RANDOMIZER_PERCENT).randomized_number
  end

  def critical_hit_damage
    if lucky?
      damage = natural_damage*(CRITICAL_HIT_PERCENT/100)
      NumberRandomizer.new(damage, CRITICAL_DAMAGE_RANDOMIZER_PERCENT).randomized_number
    else
      0
    end
  end

  def defense_bonus
    armor + agility_defense_bonus
  end

  def attack_speed
    calculated_speed = DEFAULT_ATTACK_SPEED - agility*((DEFAULT_ATTACK_SPEED-MAX_ATTACK_SPEED)/100)
    calculated_speed < MAX_ATTACK_SPEED ? MAX_ATTACK_SPEED : calculated_speed
  end

  def recalculate_health!(enemy_attack_damage)
    calculated_damage = (enemy_attack_damage-defense_bonus)
    calculated_damage = rand(MIN_DAMAGE_RAND) if calculated_damage < 0
    @health -= calculated_damage
    calculated_damage
  end

  def attacks enemy
    real_damage = enemy.recalculate_health!(attack_damage)
    puts "#{name_and_health} dealt #{real_damage.round}pts of damage to #{enemy.name_and_health}".colorize( :light_blue )
  end

  def alive?
    health > 0
  end

  def dead?
    !alive?
  end

  def name_and_health
    "#{name}(#{health.round})"
  end

  private

  def agility_defense_bonus
    agility_defense = agility*(AGILITY_DEFENSE_BONUS_PERCENT/100)
    NumberRandomizer.new(agility_defense, AGILITY_DEFENSE_BONUS_RANDOMIZER_PERCENT).randomized_number
  end

  def natural_damage
    strength*STRENGTH_TO_DAMAGE_RATIO
  end

  def lucky?
    luck >= rand(100)
  end
end