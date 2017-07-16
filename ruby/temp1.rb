require "cheepcreep/version"
require "cheepcreep/init_db"
require "httparty"
require "pry"

module Cheepcreep
  class GithubUser < ActiveRecord::Base
    validates :login, presence: true
  end
end

class Github
  include HTTParty
  base_uri 'https://api.github.com'
  basic_auth ENV['GITHUB_USER'], ENV['GITHUB_PASS']

  def get_user(screen_name)
    result = self.class.get("/users/#{screen_name}")
    puts "#{result.headers['x-ratelimit-remaining']} requests left!"
    JSON.parse(result.body)
  end

  def list_user_teams
    result = self.class.get("/user/teams")
    JSON.parse(result.body)
  end

  def create_repo(opts={})
    options = {:body => opts.to_json}
    result = self.class.post("/user/repos", options)
    JSON.parse(result.body)
  end

  def follow_user(screen_name)
    self.class.put("/user/following/#{screen_name}")
  end

  def unfollow_user(screen_name)
    self.class.delete("/user/following/#{screen_name}")
  end

  def get_team_members(id)
    result = self.class.get("/teams/#{id}/members")
    JSON.parse(result.body)
  end

  def update_user(opts={})
    options = {:body => opts.to_json}
    result = self.class.patch('/user', options)
  end

  def get_user_endpoint(endpoint, screen_name, page=1, per_page=20)
    options = {:query => {:page => page, :per_page => per_page}}
    result = self.class.get("/users/#{screen_name}#{endpoint}", options)
    puts "#{result.headers['x-ratelimit-remaining']} requests left!"
    JSON.parse(result.body)
  end

  def get_followers(screen_name, page=1, per_page=20)
    get_user_endpoint('/followers', screen_name, page, per_page)
  end

  def get_gists(screen_name, page=1, per_page=20)
    get_user_endpoint('/gists', screen_name, page, per_page)
  end

  # def get_followers(screen_name, page=1, per_page=20)
  #   options = {:query => {:page => page, :per_page => per_page}}
  #   result = self.class.get("/users/#{screen_name}/followers", options)
  #   puts "#{result.headers['x-ratelimit-remaining']} requests left!"
  #   JSON.parse(result.body)
  # end

  # def get_gists(screen_name, page=1, per_page=20)
  #   options = {:query => {:page => page, :per_page => per_page}}
  #   result = self.class.get("/users/#{screen_name}/gists", options)
  #   puts "#{result.headers['x-ratelimit-remaining']} requests left!"
  #   JSON.parse(result.body)
  # end
end

def add_github_user(screen_name)
  user = github.get_user(screen_name)
  Cheepcreep::GithubUser.create(:login         => json['login'],
                                :name          => json['name'],
                                :blog          => json['blog'],
                                :followers     => json['followers'],
                                :following     => json['following'],
                                :public_repos  => json['public_repos'])
end

def monday_hw(github)
  add_github_user('redline6561')

  followers = github.get_followers('redline6561', 1, 100)
  followers.map { |x| x['login'] }.sample(20).each do |username|
    add_github_user(username)
  end

  Cheepcreep::GithubUser.order(:followers => :desc).each do |u|
    puts "User: #{u.login}, Name: #{u.name}, Followers: #{u.followers}"
  end
end

github = Github.new

binding.pry