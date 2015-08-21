module FightersHelper
  def fighter_full_name(fighter)
    "#{fighter.first_name.capitalize} #{fighter.last_name.capitalize}"
  end
end
