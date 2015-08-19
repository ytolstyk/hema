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
  { name: 'longsword test', weapon_type: 'steel' },
  { name: 'rapier', weapon_type: 'steel' }
]

SCORES = [
  { target: 'head', points: 4 },
  { target: 'torso', points: 3 },
  { target: 'arm', points: 1 },
  { target: 'leg', points: 2 }
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

Event.create(EVENTS).each do |event|
  event.tournaments.create(TOURNAMENTS)
end

Tournament.all.each_with_index do |tournament|
  tournament.pools.first.fighters.create(PLAYERS)
end

Tournament.all.each_with_index do |tournament|
  tournament.scores.create(SCORES)
end