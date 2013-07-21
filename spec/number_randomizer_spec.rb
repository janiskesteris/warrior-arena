require_relative "../battle_arena"

describe NumberRandomizer do

  describe "#randomized_number" do
    subject(:randomizer){ NumberRandomizer.new(100, 50) }

    context "with 50% of number value" do
      before do
        randomizer.stub(:addition_or_subtraction) { :+ }
        Kernel.stub(:rand).with(50.0) { 50 }
      end
      its(:randomized_number) { should == 150 }
    end

    context "with 100% of number value" do
      subject(:randomizer){ NumberRandomizer.new(100, 100) }
      before do
        randomizer.stub(:addition_or_subtraction) { :+ }
        Kernel.stub(:rand).with(100.0) { 100 }
      end
      its(:randomized_number) { should == 200 }
    end

    context "with subtraction" do
      before do
        randomizer.stub(:addition_or_subtraction) { :- }
        Kernel.stub(:rand).with(50.0) { 50 }
      end
      its(:randomized_number) { should == 50 }
    end
  end

end