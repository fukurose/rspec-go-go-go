# frozen_string_literal: true

RSpec.describe RSpecGoGoGo::ProgressFramer do
  let(:counter) { RSpecGoGoGo::ProgressCounter.new(3) }

  context "when no progress" do
    it "The number of executions and failures should be displayed." do
      expect(described_class.result(counter)).to eq "0 examples, 0 failures"
    end

    it "progress rate must be 0" do
      expect(described_class.rate(counter)).to eq "  0%"
    end

    it "progress bar is not displayed." do
      expect(described_class.bar(counter)).to eq "|                                                            |"
    end
  end

  context "when in progress" do
    before do
      counter.passed
      counter.failed
    end

    it "The number of executions and failures should be displayed." do
      expect(described_class.result(counter)).to eq "2 examples, 1 failures"
    end

    it "progress rate must be 0" do
      expect(described_class.rate(counter)).to eq " 67%"
    end

    it "progress rate bar should be displayed.(until halfway point)" do
      expect(described_class.bar(counter)).to eq "|========================================                    |"
    end
  end

  context "when completed progress" do
    before do
      counter.passed
      counter.failed
      counter.failed
    end

    it "The number of executions and failures should be displayed." do
      expect(described_class.result(counter)).to eq "3 examples, 2 failures"
    end

    it "progress rate must be 0" do
      expect(described_class.rate(counter)).to eq "100%"
    end

    it "progress rate bar should be displayed.(until the end)" do
      expect(described_class.bar(counter)).to eq "|============================================================|"
    end
  end
end
