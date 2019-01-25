class Episode
  attr_accessor :watched

  def initialize(options = {})
    @watched = options[:watched]
  end

  def mark_as_watched
    @watched = true
  end

  def watched?
    @watched
  end
end
