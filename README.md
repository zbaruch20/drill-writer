# drill-writer

*DrillWriter* is a web application and API that allows users to create, save, and view OSUMB fundamentals drills. It is implemented as a Ruby on Rails app, using PostgreSQL as its backend database. The front-end is separate from the API, and is built on React with the addition of Bootstrap for styling.


## Table of Contents

* [Database Design](#database-design)
    * [Tables and Attributes](#tables-and-attributes)
* [API Endpoints](#api-endpoints)
* [Authentication](#user-authentication)
* [Deployment](#deployment-to-heroku)

----

# Database Design

This app uses PostgreSQL for its database. This database stores information about the app's user accounts, the created drills, the moves in each drill, and the basic types of OSUMB fundamentals. Below is the entity-relationship diagram for the database (not including authentication info):

![Entity-Relationship Diagram](/diagrams/entity_relationship_diagram.jpg)

This translates to the following relational model, which was used when creating the schema:

![Relational Model](/diagrams/relational_model.jpg)

Note that the `Fundamentals` table is populated in [seeds.rb](/db/seeds.rb), and cannot be accessed by the API. This merely serves to store the names and types of each OSUMB fundamental (e.g., forward march, box TTR, right horn slide), which is referenced by the entries in the `Moves` table.

In the future, I plan to introduce an administrator role who can access the `Fundamentals` table through the API.

## Tables and Attributes

Below is a brief description of each table and attribute as found in the relational model above:

### `User` - User accounts
* `id:integer` -  Primary key, generated automatically by `ActiveRecord`
* `username:string` - The user's display name
* `email:string` - The user's email, used for account creation and confirmation (see [Authentication](#user-authentication) for more info)
* `password_digest:string` - The encrypted hash of the user's password (see [Authentication](#user-authentication) for more info)

### `Drill` - The OSUMB fundamentals drills that users can create
* `id:integer` - Primary key, generated automatically by `ActiveRecord`
* `name:string` - The name of the drill
* `description:text` - The description of the drill
* `style:integer` - Enum value representing the style of the drill. This affects how the drill is displayed. The enum values are as follows:
    * 0: Horns down
    * 1: Horns up, keep horn up at the end
    * 2: Horns up, horns down at the end
    * 3: Ramp drill
* `ramp_cadences:integer` - The number of ramp cadences; only used if the drill is a ramp drill. If it is a ramp drill and the value of this attribute is 0, it is interpreted as *"cadences ad infinitum"* when displaying the drill.
* `user_id:integer` - Foreign key to the ID of the user that wrote the drill

### `Move` - The individual moves in a drill
* `id:integer` - Primary key, generated automatically by `ActiveRecord`
* `num_eights:integer` - The number of "eights" (i.e., number of 5-yard increments) that the move lasts; only used if the move is not a turn (e.g., forward march, left lateral slide)
* `position:integer` - The relative position of the move within the drill it is a part of.
* `drill_id:integer` - Foreign key to the ID of the drill that contains the move
* `fundamental_id:integer` - Foreign key to the ID of the fundamental that the move represents

### `Fundamental` - OSUMB fundamentals building blocks. Only modified during initial database seeding.
* `id:integer` - Primary key, generated automatically by `ActiveRecord`
* `name:string` - The name of the fundamental
* `type:integer` - Enum value representing the type of the move. This affects which types of moves can precede or follow the current move. The enum values are as follows:
    * 0: Forward move (e.g., forward march, 6-to-5 adjusted step, right oblique 8-to-5)
    * 1: Backward or lateral move (e.g., backward march, left lateral slide, step sides)
    * 2: Horn slide (e.g., right horn slide)
    * 3: Flank (e.g., right flank)
    * 4: Slow turn (e.g., slow turn left 180 degrees in 8 counts)
    * 5: TTR (e.g., regular TTR, slide TTR on 4)
    * 6: Hats off. Note that this type of move is only allowed in a horns up drill. If this move is the last move of the drill, it will be rendered as *"Hats off Ohio"*. If this move is anywhere else in the drill, it will be rendered as *"Hats off rest 1-2-3"*.

---

# API Endpoints

All API endpoints are prefixed with `/api/v1/...`. This separates the URLs of the back-end API (developed in Rails) from the URLs of the front-end views (developed in React).

//TODO - Documentation for each endpoint

---

# User Authentication

//TODO - Describe user authentication with `BCrypt`

---

# Deployment to Heroku

//TODO - When the whole thing is done and deployed, describe how I did it