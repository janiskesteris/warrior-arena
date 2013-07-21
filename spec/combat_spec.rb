require_relative "../battle_arena"

describe Combat do
  let(:attacker) { Warrior.new({health: 100, armor: 1, strength: 100, agility: 100, luck: 50}) }
  let(:defender) { Warrior.new({health: 100, armor: 1, strength: 10, agility: 0, luck: 10}) }

  describe "#battle" do
    subject(:combat){ Combat.new(attacker, defender) }
    before do
      combat.fight
    end
    it "kills defender" do
      defender.dead?.should be_true
    end
  end

end