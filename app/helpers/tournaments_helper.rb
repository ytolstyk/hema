module TournamentsHelper
  def weapon_type_options
    {
      long_sword: 'Long Sword',
      rapier: 'Rapier',
      side_sword: 'Side Sword',
      single_stick: 'Single Stick'
    }
  end

  def gender_options
    {
      men: 'Men',
      women: 'Women',
      both: 'Both'
    }
  end

  def score_options
    {
      arm: 'Arm',
      head: 'Head',
      leg: 'Leg',
      torso: 'Torso'
    }
  end
end
