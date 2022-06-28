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
    "Mark Time",
    "Forward",
    "6-to-5",
    "10-to-5",
    "12-to-5",
    "16-to-5",
    "18-to-5",
    "20-to-5",
    "24-to-5",
    "Left Oblique 8-to-5",
    "Left Oblique 6-to-5",
    "Right Oblique 8-to-5",
    "Right Oblique 6-to-5",
    "Step Kicks",
  ],
  backward_or_lateral: [
    "Backward",
    "12-to-5 Backward",
    "16-to-5 Backward",
    "Left Lateral Slide",
    "Left Backward Lateral Slide",
    "Right Lateral Slide",
    "Right Backward Lateral Slide",
  ],
  horn_slide: [
    "Left Horn Slide",
    "Right Horn Slide",
  ],
  flank: [
    "Left Flank",
    "Right Flank",
    "Up-Step-Turn to the Left",
    "Up-Step-Turn to the Right",
    "Up-Step-Turn TTR",
  ],
  slow_turn: [
    "Slow Turn to the Left 90 degrees",
    "Slow Turn to the Left 180 degrees",
    "Slow Turn to the Left 270 degrees",
    "Slow Turn to the Left 360 degrees",
    "Slow Turn to the Right 90 degrees",
    "Slow Turn to the Right 180 degrees",
    "Slow Turn to the Right 270 degrees",
    "Slow Turn to the Right 360 degrees",
  ],
  ttr: [
    "Regular TTR",
    "Box TTR",
    "Slide TTR on 2",
    "Slide TTR on 4",
    "Slide TTR on 6",
  ],
  hats_off: [
    "Hats Off",
  ],
}

fundamentals_params = types_and_moves.map { |type, names| [type].product names }.
  flatten(1).
  map { |params| { name: params[1], move_type: params[0] } }

puts fundamentals_params if DEBUG
fundamentals = Fundamental.create! fundamentals_params

# Example user
example_user = User.create! username: "example_user",
                            email: "example-email@example.com",
                            password: ENV["DRILL_WRITER_EXAMPLE_USER_PASSWORD"],
                            password_confirmation: ENV["DRILL_WRITER_EXAMPLE_USER_PASSWORD"]
puts example_user.attributes if DEBUG

# Example drill
example_drill = Drill.create! name: "Example Drill",
                              description: "My totally awesome example drill!",
                              user: example_user,
                              style: :horns_up_down
puts example_drill.attributes if DEBUG

move_names_and_eights = [
  ["Forward", 2],
  ["Box TTR"],
  ["Left Oblique 8-to-5", 1],
  ["Box TTR"],
  ["Right Oblique 8-to-5", 1],
  ["Box TTR"],
  ["Forward", 2],
]
moves_params = move_names_and_eights.map { |m| { drill: example_drill, fundamental: (Fundamental.find_by name: m[0]), num_eights: m[1] } }
puts moves_params if DEBUG
moves = Move.create! moves_params
