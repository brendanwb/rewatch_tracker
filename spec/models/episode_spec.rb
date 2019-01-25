require 'rails_helper'

RSpec.describe Episode do
  it "can distinguish a watched episode" do
    episode = Episode.new
    expect(episode).not_to be_watched
    episode.mark_as_watched
    expect(episode).to be_watched
  end
end
