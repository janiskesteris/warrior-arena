require_relative "../battle_arena"

describe Battlefield do

  describe "#initialize" do
    subject(:battlefield){ Battlefield.new(3) }
    it "generates random warriors" do
      battlefield.warriors.count == 3
    end
  end

  describe "#warriors_alive" do
    subject(:battlefield){ Battlefield.new(3) }
    before do
      battlefield.warriors.last.health = -1
    end
    it "returns only alive warriors" do
      battlefield.warriors.count == 2
    end
  end

  describe "#no_winner?" do
    subject(:battlefield){ Battlefield.new(2) }
    context "true" do
      its(:no_winner?){ should be_true }
    end
    context "false" do
      before do
        battlefield.warriors.last.health = -1
      end
      its(:no_winner?){ should be_false }
    end
  end

  describe "#opponent_for" do
    context "with existing warrior" do
      subject(:battlefield){ Battlefield.new(2) }
      it "finds opponent" do
        battlefield.opponent_for(battlefield.warriors.first).should be_a(Warrior)
      end
    end
    context "with no warriors" do
      subject(:battlefield){ Battlefield.new(0) }
      it "returns nil" do
        battlefield.opponent_for(battlefield.warriors.first).should be_nil
      end
    end
    context "with himself as only warrior" do
      subject(:battlefield){ Battlefield.new(1) }
      it "returns nil" do
        battlefield.opponent_for(battlefield.warriors.first).should be_nil
      end
    end
  end

  describe "#fight_to_death" do
    let(:hero) { Warrior.new({name: "Thor", health: 500, armor: 100, strength: 300, agility: 200, luck: 100}) }
    subject(:battlefield){ Battlefield.new(1) }
    before do
      battlefield.warriors << hero
    end
    it "should find winner" do
      battlefield.fight_to_death
      battlefield.spectate
      battlefield.warriors_alive.last.should == hero
    end
  end

end