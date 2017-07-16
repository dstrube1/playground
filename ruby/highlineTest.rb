require 'highline/import'

choose do |menu|
  menu.prompt = "Please choose your favorite programming language?  "

  menu.choice(:ruby) { say("Good choice!") }
  menu.choices(:python, :perl) { say("Not from around here, are you?") }
end

#todos = TooDooApp.new
#todos.run
