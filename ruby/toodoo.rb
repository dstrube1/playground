require "toodoo/version"
require "toodoo/init_db"
require 'highline/import'
require 'pry'

module Toodoo

  class User < ActiveRecord::Base
    validates :name, presence: true
    has_many :lists
    has_many :items, through :lists
  end

  class List <ActiveRecord::Base
    validates :list, presence: true
    belongs_to :user
    has_many :items
  end

  class Item <ActiveRecord::Base
    belongs_to :list
  end

end

class TooDooApp
   Include Toodoo

  def initialize
    @user = nil
    @todos = nil
    @show_done = nil
  end

  def new_user
    say("Creating a new user:")
    name = ask("Username?") { |q| q.validate = /\A\w+\Z/ }
    @user = Toodoo::User.create(:name => name)
    say("We've created your account and logged you in. Thanks #{@user.name}!")
  end

  def login
    choose do |menu|
      menu.prompt = "Please choose an account: "

      Toodoo::User.find_each do |u|
        menu.choice(u.name, "Login as #{u.name}.") { @user = u }
      end

      menu.choice(:back, "Just kidding, back to main menu!") do
        say "You got it!"
        @user = nil
      end
    end
  end

  def delete_user
    choices = 'yn'
    delete = ask("Are you *sure* you want to stop using TooDoo?") do |q|
      q.validate =/\A[#{choices}]\Z/
      q.character = true
      q.confirm = true
    end
    if delete == 'y'
      @user.destroy
      @user = nil
    end
  end

  def new_todo_list
    say('Creating a new todo list.')
    title = ask("What do you want to name your Toodoo list as?")
    # TODO: This should create a new todo list by getting input from the user.
    # The user should not have to tell you their id.
    # Create the todo list in the database and update the @todos variable.
    @todos = @user.lists.create(:title => title)
  end

  def pick_todo_list
    choose do |menu|
      menu.prompt('Which Toodoo list do you want to use?')
      @user.list.find_each do |l|
        menu.choice(l.title, "You've selected #{l.title}!" ) { @todos = l }
      # TODO: This should get get the todo lists for the logged in user (@user).
      # Iterate over them and add a menu.choice line as seen under the login method's
      # find_each call. The menu choice block should set @todos to the todo list.
        end
      end
      menu.choice(:back, "Just kidding, back to the main menu!") do
        say "You got it!"
      @todos = nil
      end
    end
  end

  def delete_todo_list
    choices = 'yn'
    delete = ask("Are you *sure* you want to delete this list?") do |q|
      q.validate =/\A[#{choices}]\Z/
      q.character = true #why??
      q.confirm = true
    end
      if delete == 'y'
      list.destroy
      @todos = nil
      end
    # TODO: This should confirm that the user wants to delete the todo list.
    # If they do, it should destroy the current todo list and set @todos to nil.
  end

  def new_task
    gets_task = ask("What task would you like to add?")
    item_name = @todos.items.create(:name => gets_task)
    # DATES WTF.... *sad panda*
    due_date = ask("Due date? Select date as MM/DD/YYYY or hit enter to skip.")
      case when due_date == ""
        item_name.update(dd: NULL)
      case when due_date == /^(0[1-9]|1[0-2])\/(0[1-9]|1\d|2\d|3[01])\/(19|20)\d{2}$/
        item_name.update(dd:) ###?????
      end
    # TODO: This should create a new task on the current user's todo list.
    # It must take any necessary input from the user. A due date is optional.
  end

  ## NOTE: For the next 3 methods, make sure the change is saved to the database.
  def mark_done
    choose do |menu|
      menu.prompt('Which Toodoo task is done?')
    @todos.items.find_each do |i|
      menu.choice(i.name "#{i.name} is done!") #wtf.
      item_update = @todos.item.find_by(name: i.name)
      item_update.update(task_done: true)
    # TODO: This should display the todos on the current list in a menu
    # similarly to pick_todo_list. Once they select a todo, the menu choice block
    # should update the todo to be completed.
      end
    end
  end

  def change_due_date #wtf?
    choose do |menu|
      menu.prompt('What is the new date?')
    @todos.items.find_each do |i|
    menu.choice(i.name) { change_due_date }
    # TODO: This should display the todos on the current list in a menu
    # similarly to pick_todo_list. Once they select a todo, the menu choice block
    # should update the due date for the todo. You probably want to use
    # `ask("foo", Date)` here.
      end
    end
  end

  def edit_task #no idea... can't think...
    choose do |menu|
      menu.prompt('Which Toodoo task needs editing?')
    menu.choice(:edit_task, "Update a task's description.") { edit_task }
    @todos.items.find_each do |i|
      menu.choice(i.name "#{i.name} is done!") #wtf.
      item_update = @todos.item.find_by(name: i.name)
      item_update.update(task_done: true)


    # TODO: This should display the todos on the current list in a menu
    # similarly to pick_todo_list. Once they select a todo, the menu choice block
    # should change the name of the todo.
  end

#i can't even...
  def show_overdue
    menu.choice(:show_overdue, "Show a list of task's that are overdue, oldest first.") { show_overdue }
    # TODO: This should print a sorted list of todos with a due date *older*
    # than `Date.now`. They should be formatted as follows:
    # "Date -- Eat a Cookie"
    # "Older Date -- Play with Puppies"
  end

  def run
    puts "Welcome to your personal TooDoo app."
    loop do
      choose do |menu|
        menu.layout = :menu_only
        menu.shell = true

        # Are we logged in yet?
        unless @user
          menu.choice(:new_user, "Create a new user.") { new_user }
          menu.choice(:login, "Login with an existing account.") { login }
        end

        # We're logged in. Do we have a todo list to work on?
        if @user && !@todos
          menu.choice(:delete_account, "Delete the current user account.") { delete_user }
          menu.choice(:new_list, "Create a new todo list.") { new_todo_list }
          menu.choice(:pick_list, "Work on an existing list.") { pick_todo_list }
          menu.choice(:remove_list, "Delete a todo list.") { delete_todo_list }
        end

        # Let's work on some todos!
        if @todos
          menu.choice(:new_task, "Add a new task.") { new_task }
          menu.choice(:mark_done, "Mark a task finished.") { mark_done }
          menu.choice(:move_date, "Change a task's due date.") { change_due_date }
          menu.choice(:edit_task, "Update a task's description.") { edit_task }
          menu.choice(:show_done, "Toggle display of tasks you've finished.") { @show_done = !!@show_done }
          menu.choice(:show_overdue, "Show a list of task's that are overdue, oldest first.") { show_overdue }
          menu.choice(:back, "Go work on another Toodoo list!") do
            say "You got it!"
            @todos = nil
          end
        end

        menu.choice(:quit, "Quit!") { exit }
      end
    end
  end
end

binding.pry

todos = TooDooApp.new
todos.run
