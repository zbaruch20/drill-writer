# JSON render for single user

json.(user, :id, :username, :email)
json.drills do |json|
  json.array! user.drills do |drill|
    json.(drill, :id, :name, :description)
  end
end
