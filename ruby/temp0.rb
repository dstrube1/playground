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

binding.pry

#todos = TooDooApp.new
#todos.run
