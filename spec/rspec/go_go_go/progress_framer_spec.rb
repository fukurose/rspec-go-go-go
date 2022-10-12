# frozen_string_literal: true

RSpec.describe RSpec::GoGoGo::ProgressFramer do
  let(:counter) { RSpec::GoGoGo::ProgressCounter.new(10) }

  context "when terminal width is 60" do
    before { allow(described_class).to receive(:terminal_width).and_return(60) }

    it "width is 27 (60 - 24(result) - 4(rate) - 5(blank * 3 and '|' * 2 ) = 27)" do
      expect(described_class.cal_width(counter)).to eq 27
    end
  end

  context "when width is 60" do
    before { allow(described_class).to receive(:cal_width).and_return(60) }

    context "when no progress" do
      it "The number of executions and failures should be displayed." do
        expect(described_class.result(counter)).to eq " 0 examples,  0 failures"
      end

      it "progress rate must be 0" do
        expect(described_class.rate(counter)).to eq "  0%"
      end

      it "progress bar is not displayed." do
        expect(described_class.bar(counter)).to eq "|------------------------------------------------------------|"
      end
    end

    context "when in progress" do
      before do
        counter.passed
        counter.passed
        counter.passed
        counter.failed
        counter.failed
      end

      it "The number of executions and failures should be displayed." do
        expect(described_class.result(counter)).to eq " 5 examples,  2 failures"
      end

      it "progress rate must be 50%" do
        expect(described_class.rate(counter)).to eq " 50%"
      end

      it "progress rate bar should be displayed.(until halfway point)" do
        expect(described_class.bar(counter)).to eq "|GoGoGoGoGoGoGoGoGoGoGoGoGoGoGo------------------------------|"
      end
    end

    context "when completed progress" do
      before do
        counter.passed
        counter.passed
        counter.passed
        counter.failed
        counter.failed
        counter.passed
        counter.passed
        counter.passed
        counter.failed
        counter.failed
      end

      it "The number of executions and failures should be displayed." do
        expect(described_class.result(counter)).to eq "10 examples,  4 failures"
      end

      it "progress rate must be 0" do
        expect(described_class.rate(counter)).to eq "100%"
      end

      it "progress rate bar should be displayed.(until the end)" do
        expect(described_class.bar(counter)).to eq "|============================================================|"
      end
    end
  end
end
