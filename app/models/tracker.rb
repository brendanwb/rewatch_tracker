class Tracker
  attr_accessor :episodes, :new_episodes_start_date

  def initialize(options = {})
    @episodes = []
    @new_episodes_start_date = options[:new_episodes_start_date]
  end

  def done?
    unwatched_episodes.empty?
  end

  def total_episodes
    episodes.count
  end

  def remaining_episodes
    unwatched_episodes.count
  end

  def unwatched_episodes
    episodes.reject(&:watched?)
  end

  def days_before_new_episodes
    ((new_episodes_start_date - Date.current).abs).round
  end

  def on_schedule?
    return false if (days_before_new_episodes/1.0).nan?
    remaining_episodes <=  days_before_new_episodes
  end
end
