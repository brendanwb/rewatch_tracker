require 'rails_helper'

RSpec.describe Tracker do
  it "considers a tracker with no episodes unwatched" do
    tracker = Tracker.new
    expect(tracker.done?).to be_truthy
  end

  it "knows that a tracker with an unwatched episodes is not done" do
    tracker = Tracker.new
    episode = Episode.new
    tracker.episodes << episode

    expect(tracker.done?).to be_falsy
  end

  it "marks a tracker done if the episodes are watched" do
    tracker = Tracker.new
    episode = Episode.new
    tracker.episodes << episode
    episode.mark_as_watched

    expect(tracker).to be_done
  end

  it "knows days before new episodes start" do
    tracker = Tracker.new(new_episodes_start_date: 156.days.from_now.to_date)
    expect(tracker.days_before_new_episodes).to eq(156)
  end

  it "knows if it is on schedule" do
    tracker       = Tracker.new
    episode_one   = Episode.new
    episode_two   = Episode.new
    episode_three = Episode.new
    tracker.episodes << [episode_one, episode_two, episode_three]

    tracker.new_episodes_start_date = 2.weeks.from_now.to_date
    expect(tracker).not_to be_on_schedule
    tracker.new_episodes_start_date = 22.weeks.from_now.to_date
    expect(tracker).to be_on_schedule
  end

  it "properly estimates a blank tracker" do
    tracker = Tracker.new
    expect(tracker.days_before_new_episodes.nan?).to be_truthy
    expect(tracker).not_to be_on_schedule
  end

  describe "estimates" do
    let(:tracker) { Tracker.new }
    let(:watched) { Episode.new(watched: true) }
    let(:first_unwatched) { Episode.new }
    let(:second_unwatched) { Episode.new }

    before(:example) do
      tracker.episodes = [watched, first_unwatched, second_unwatched]
    end

    it "can calculate the number of episodes" do
      expect(tracker.total_episodes).to eq(3)
    end

    it "can calculate remaining episodes" do
      expect(tracker.remaining_episodes).to eq(2)
    end
  end
end
