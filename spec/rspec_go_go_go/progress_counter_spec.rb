# frozen_string_literal: true

RSpec.describe RSpecGoGoGo::ProgressCounter do
  it "argument is set to the total" do
    expect(described_class.new(3).total).to(eq(3))
  end

  context "with the initial state" do
    let(:progress) { described_class.new(3) }

    it "passed count must be 0" do
      expect(progress.passes).to eq 0
    end

    it "failed count must be 0" do
      expect(progress.failures).to eq 0
    end

    it "check count must be 0" do
      expect(progress.checks).to eq 0
    end

    it "rate must be 0" do
      expect(progress.rate).to eq 0
    end
  end

  context "with the once-passed state." do
    let(:progress) { described_class.new(3).tap(&:passed) }

    it "passed count must be 1" do
      expect(progress.passes).to eq 1
    end

    it "failed count must be 0" do
      expect(progress.failures).to eq 0
    end

    it "check count must be 1" do
      expect(progress.checks).to eq 1
    end

    it "rate must be 0.3" do
      expect(progress.rate).to eq 0.33
    end
  end

  context "with the once-failed state." do
    let(:progress) { described_class.new(3).tap(&:failed) }

    it "passed count must be 0" do
      expect(progress.passes).to eq 0
    end

    it "failed count must be 1" do
      expect(progress.failures).to eq 1
    end

    it "check count must be 1" do
      expect(progress.checks).to eq 1
    end

    it "rate must be 0.3" do
      expect(progress.rate).to eq 0.33
    end
  end

  context "with the once-passed and two-failed state." do
    let(:progress) do
      described_class.new(3).tap do |progress|
        progress.passed
        progress.failed
        progress.failed
      end
    end

    it "passed count must be 1" do
      expect(progress.passes).to eq 1
    end

    it "failed count must be 2" do
      expect(progress.failures).to eq 2
    end

    it "check count must be 3" do
      expect(progress.checks).to eq 3
    end

    it "rate must be 1.0" do
      expect(progress.rate).to eq 1.0
    end
  end
end
