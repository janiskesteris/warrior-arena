class Battlefield
  attr_accessor :warriors

  def initialize warrior_count = 2
    @warriors = warrior_count.times.map do
      Warrior.new({health: 500, armor: rand(20)+5, strength: rand(50)+10, agility: rand(100)+10, luck: rand(5)+5})
    end
    @threads = []
  end

  def fight_to_death
    @warriors.each do |warrior|
      @threads << Thread.new do
        while warrior.alive? && enemy = opponent_for(warrior)
          Combat.new(warrior, enemy).fight
        end
      end
    end
  end

  def spectate
    while no_winner?
      sleep(0.3)
    end
    winner = warriors_alive.last
    puts "The winner is #{winner.name_and_health}".green
  end

  def no_winner?
    warriors_alive.count > 1
  end

  def warriors_alive
    @warriors.select{|warrior| warrior.alive?}
  end

  def opponent_for(current_warrior)
    @warriors.shuffle.detect{|warrior| warrior != current_warrior}
  end

end