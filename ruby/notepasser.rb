require "notepasser/version"
require "notepasser/init_db"
require "camping"
require "pry"

Camping.goes :Notepasser

module Notepasser
end

module Notepasser::Models

  class User
    validates :name, presence :true, uniqueness :true, format: {with: /\A[a-z\d]*\Z/i,
      message: "no symbols, punk" }
    has_many :messages
  end

  class Message
    validates :content, presence :true, uniqueness :true
    validates :recipient_id, presence :true
    belongs_to :user
  end

end

module Notepasser::Controllers

# ip address : http://...
  class UserController < R '/users/new'
  #Users: Support adding user accounts.
  @User = Notepasser::Models::User
    def post
      new_user = @User.create(name: @input)
    end

  class UserController < R '/users//\A[a-z\d]*\Z/i'
#Users: Support retrieving and deleting user accounts.
    @User = Notepasser::Models::User

    def get(username)
      @get_user = @User.find_by(name: username)
    end

    def delete #TODO concern of auto del if get runs...
      @get_user.destroy
    end

  class MessageController < R '/users/msg/add'

#int :recipient_id, text :content, t/f :read_status
    def post_add(username)
      content = [:recipient_id, :content, :read_status]
      content.each do |c|
        @User.messages.new[c] = @input[c]
      end
    end

  end

  class MessageController < R '/users/#{username}/msg'
    @UserMessage = Notepasser::Models::User.messages
    def get_all_msg(username)
      @UserMessage.find_by(username)
    end

    def get_user_msg(username)
      @UserMessage.find_by(username)
    end
#how to pass???
    def post_status(get_user_msg(username))
      @UserMessage.find_by(get_user_msg(username))
      @UserMessage.update(read_status: @input)
      binding.pry
    end

    def delete
      binding.pry
      messages.destroy
    end
  end

---
end
