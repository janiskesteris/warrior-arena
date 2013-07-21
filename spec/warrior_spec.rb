require_relative "../battle_arena"

describe Warrior do
  context "with valid attributes" do
    subject { Warrior.new }
    its(:health) { should_not be_nil }
    its(:armor) { should_not be_nil }
    its(:strength) { should_not be_nil }
    its(:agility) { should_not be_nil }
    its(:luck) { should_not be_nil }
    its(:name) { should_not be_nil }
  end

  describe "#attack_damage" do
    subject(:warrior){ Warrior.new }
    before do
      NumberRandomizer.any_instance.stub(:randomizer) { 0 }
      warrior.stub(:natural_damage) { warrior.strength }
      warrior.strength = 100
    end

    context "with no luck and randomizer" do
      its(:attack_damage) { should == 100 }
    end

    context "with max luck" do
      before do
        warrior.luck = 100
      end
      it "adds 15% more damage to attacks 100% of the time" do
        warrior.attack_damage.should == 150
      end
    end

    context "with randomizer" do
      before do
        NumberRandomizer.any_instance.stub(:randomizer) { 10 }
        NumberRandomizer.any_instance.stub(:addition_or_subtraction) { :+ }
      end
      its(:attack_damage) { should == 110 }
    end
  end

  describe "#critical_hit_damage" do
    before do
      warrior.stub(:natural_damage) { warrior.strength }
    end
    context "with no luck" do
      subject(:warrior){ Warrior.new(strength: 100, luck: 0) }
      its(:critical_hit_damage){ should == 0 }
    end

    context "with max luck" do
      subject(:warrior){ Warrior.new(strength: 100, luck: 100) }
      before do
        NumberRandomizer.any_instance.stub(:randomizer) { 0 }
      end
      its(:critical_hit_damage){ should == 50 }
    end

    context "with max luck and randomizer" do
      subject(:warrior){ Warrior.new(strength: 100, luck: 100) }
      before do
        NumberRandomizer.any_instance.stub(:randomizer) { 5 }
        NumberRandomizer.any_instance.stub(:addition_or_subtraction) { :+ }
      end
      its(:critical_hit_damage){ should == 55 }
    end
  end

  describe "#defense_bonus" do
    before do
      NumberRandomizer.any_instance.stub(:randomizer) { 0 }
    end
    context "without arrmor and agility" do
      subject(:warrior){ Warrior.new }
      its(:defense_bonus) { should == 0 }
    end
    context "with arrmor" do
      subject(:warrior){ Warrior.new(armor: 100) }
      its(:defense_bonus) { should == 100 }
    end
    context "with aglity" do
      subject(:warrior){ Warrior.new(agility: 100) }
      its(:defense_bonus) { should == 25 }
    end
    context "with arrmor and agility" do
      subject(:warrior){ Warrior.new(agility: 100, armor: 100) }
      its(:defense_bonus) { should == 125 }
    end
  end

  describe "#attack_speed" do

    context "witout agility" do
      subject(:warrior){ Warrior.new }
      its(:attack_speed) { should == 2.0 }
    end

    context "with 50 agility" do
      subject(:warrior){ Warrior.new(agility: 50) }
      its(:attack_speed) { should == 1.25 }
    end

    context "with max agility" do
      subject(:warrior){ Warrior.new(agility: 100) }
      its(:attack_speed) { should == 0.5 }
    end

    context "with more then max agility" do
      subject(:warrior){ Warrior.new(agility: 120) }
      its(:attack_speed) { should == 0.5 }
    end

  end

  describe "#recalculate_health" do
    let(:attack_damage) { 20 }
    context "without defense bonus" do
      subject(:warrior){ Warrior.new(health: 100) }
      before do
        warrior.recalculate_health!(attack_damage)
      end

      its(:health) { should == 80 }
    end

    context "with defense bonus" do
      subject(:warrior){ Warrior.new(health: 100, armor: 10) }
      before do
        warrior.recalculate_health!(attack_damage)
      end
      its(:health) { should == 90 }
    end

  end

  describe "#attacks" do
    let(:attacker) { Warrior.new(health: 100, strength: 10) }
    let(:defender) { Warrior.new(health: 100) }
    subject(:fight) { attacker.attacks(defender) }
    before do
      fight
    end

    it "injures defender" do
      defender.health.should be < 100
    end
  end

  describe "#alive?" do
    subject(:warrior){ Warrior.new(health: health) }
    context "yes" do
      let(:health){ 100 }
      its(:alive?) { should be_true }
    end

    context "no" do
      let(:health){ 0 }
      its(:alive?) { should be_false }
    end
  end

  describe "#name_and_health" do
    subject(:warrior){ Warrior.new(name: "Alistar", health: 99).name_and_health }
    it { should == "Alistar(99)" }
  end

end