module MatchesHelper
  def time_in_minutes_from_seconds(seconds)
    Time.at(seconds).utc.strftime("%M:%S")
  end
end
