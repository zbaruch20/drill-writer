# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

DEBUG = false # Flag to print params for creates and stuff

# Fundamentals
types_and_moves = {
  forward: [
    "mark time",
    "forward march",
    "6-to-5",
    "12-to-5",
    "16-to-5",
    "24-to-5",
    "32-to-5",
    "left oblique 8-to-5",
    "left oblique 6-to-5",
    "right oblique 8-to-5",
    "right oblique 6-to-5",
  ],
  backward_or_lateral: [
    "backward march",
    "left lateral slide",
    "left backward lateral slide",
    "right lateral slide",
    "right backward lateral slide",
  ],
  horn_slide: [
    "left horn slide",
    "right horn slide",
  ],
  flank: [
    "Left flank",
    "Right flank",
    "Up-step-turn to the left",
    "Up-step-turn to the right",
    "Up-step-turn TTR",
  ],
  slow_turn: [
    "Slow turn to the left 90 degrees",
    "Slow turn to the left 180 degrees",
    "Slow turn to the left 270 degrees",
    "Slow turn to the left 360 degrees",
    "Slow turn to the right 90 degrees",
    "Slow turn to the right 180 degrees",
    "Slow turn to the right 270 degrees",
    "Slow turn to the right 360 degrees",
  ],
  ttr: [
    "Regular TTR",
    "Box TTR",
    "Slide TTR on 2",
    "Slide TTR on 4",
    "Slide TTR on 6",
  ],
  hats_off: [
    "Hats off",
  ],
}

fundamentals_params = types_and_moves.map { |type, names| [type].product names }.
  flatten(1).
  map { |params| { name: params[1], move_type: params[0] } }

puts fundamentals_params if DEBUG
fundamentals = Fundamental.create! fundamentals_params

# Example user
example_user = User.create! username: "example_user", email: "example-email@example.com", password: "Password1!"
puts example_user.attributes if DEBUG

# Example drill
example_drill = Drill.create! name: "Example Drill", description: "My totally awesome example drill!", user: example_user, style: :horns_up_down
puts example_drill.attributes if DEBUG

move_names_and_eights = [
  ["forward march", 2],
  ["Box TTR"],
  ["left oblique 8-to-5", 1],
  ["Box TTR"],
  ["right oblique 8-to-5", 1],
  ["Box TTR"],
  ["forward march", 2],
]
moves_params = move_names_and_eights.map { |m| { drill: example_drill, fundamental: (Fundamental.find_by name: m[0]), num_eights: m[1] } }
puts moves_params if DEBUG
moves = Move.create! moves_params
