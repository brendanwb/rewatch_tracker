require 'rails_helper'

RSpec.describe Tracker do
  it "considers a tracker with no shows to be done" do
    tracker = Tracker.new
    expect(tracker.done?).to be_truthy
  end
end
