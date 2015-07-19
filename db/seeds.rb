# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

EVENTS = [
  { name: 'CombatCon', date: '04-01-2015', organizer: 'Blood and Iron', location: 'Las Vegas' },
  { name: 'SoCal' },
  { name: 'CombatCon', date: '02-02-2014', organizer: 'KRON'}
]

TOURNAMENTS = [
  { name: 'longsword', weapon_type: 'steel' },
  { name: 'sabre', weapon_type: 'steel' },
  { name: 'longsword', weapon_type: 'synthetic' },
  { name: 'rapier', weapon_type: 'steel' }
]

SCORES = [
  { target: 'head', points: 4 },
  { target: 'torso', points: 3 },
  { target: 'arm', points: 1 },
  { target: 'leg', points: 2 },
  { target: 'throw', points: 2 }
]

PLAYERS = [
  { first_name: 'steve', last_name: 'martin' },
  { first_name: 'mike', last_name: 'hip', school: 'KRON' },
  { first_name: 'david', last_name: 'fortunado', school: 'Iron Lotus' },
  { first_name: 'ashley', last_name: 'svenson' },
  { first_name: 'mike', last_name: 'martin' },
  { first_name: 'john', last_name: 'white' },
  { first_name: 'ellie', last_name: 'jackson' },
  { first_name: 'dasha', last_name: 'bronson' }
]

Fighter.create(PLAYERS)

Event.create(EVENTS).each_with_index do |event, index|
  event.tournaments.create(TOURNAMENTS[index % TOURNAMENTS.length ])
  event.tournaments.create(TOURNAMENTS[(index + 1) % TOURNAMENTS.length])
end

Tournament.all.each_with_index do |tournament, index|
  tournament.tournament_fighters.create(fighter_id: index % PLAYERS.length)
  tournament.tournament_fighters.create(fighter_id: index + 1 % PLAYERS.length)
  tournament.tournament_fighters.create(fighter_id: index + 2 % PLAYERS.length)
  tournament.tournament_fighters.create(fighter_id: index + 3 % PLAYERS.length)
end

Tournament.all.each_with_index do |tournament, index|
  tournament.scores.create(SCORES[index % SCORES.length])
  tournament.scores.create(SCORES[(index + 1) % SCORES.length])
  tournament.scores.create(SCORES[(index + 2) % SCORES.length])
  tournament.scores.create(SCORES[(index + 3) % SCORES.length])
end