# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

EVENTS = [
  { name: 'CombatCon Test', date: '04-01-2015', organizer: 'Blood and Iron', location: 'Las Vegas' }
]

TOURNAMENTS = [
  { name: 'Longsword Test', weapon_type: 'steel' },
  { name: 'Rapier Test', weapon_type: 'steel' }
]

SCORES = [
  { target: 'head', points: 4 },
  { target: 'torso', points: 3 },
  { target: 'arm', points: 1 },
  { target: 'leg', points: 2 }
]

PLAYERS = [
  { first_name: 'steve', last_name: 'test' },
  { first_name: 'mike', last_name: 'test', school: 'KRON' },
  { first_name: 'david', last_name: 'test', school: 'Iron Lotus' },
  { first_name: 'ashley', last_name: 'test' },
  { first_name: 'mike', last_name: 'test' },
  { first_name: 'john', last_name: 'test' },
  { first_name: 'ellie', last_name: 'test' },
  { first_name: 'dasha', last_name: 'test' }
]

Event.create(EVENTS).each do |event|
  event.tournaments.create(TOURNAMENTS)
end

Tournament.all.each_with_index do |tournament|
  tournament.pools.first.fighters.create(PLAYERS)
end

Tournament.all.each_with_index do |tournament|
  tournament.scores.create(SCORES)
end