#Chicken Game
module Killable #maybe...

module Fight

  def attack
    attack_damage = health -= damage
    attack_status
  end

  def attack_damage_count
    puts "-#{damage} damage! That #{other.name} has #{other.health} health left!"
  end

end

module EndGame

  def victory?
    if Chicken.health == 0 && BossChick.health == 0
      puts "You've won and killed the boss of all chickens! Now go home and cook. It's worth it."
    elsif Fool.health == 0
      puts "You are dead. The chickens will have a feast tonight. You are such a dissappointment."
    else
      return false
    end
  end

end

class Weapon
  attr_reader :weapon_arr
  @@weapon_arr = ["spoon","pillow","butter knife","sword","gun"]

  def initialize(weapon_arr)
    @weapon = weapon_arr
  end

  def get_weapon
    random_weapon = weapon_arr.sample
    keep_weapon?(random_weapon)
  end

  def keep_weapon?(random_weapon)
    puts "You are handed a #{random_weapon}. Do you want keep it or get a different one? (Select '1' for keep or '2' to get a different one)"
    answer = gets.chomp
    until /[12]/.match(answer) #TODO - fix bug if you include 1 or 2 in a multi char string... returns else..
      puts "Spouse: So you are about to hunt a human eating chicken but you can't pick the correct number? I worry about you."
      puts "Spouse: Select '1' for keep or '2' to get a different one."
      answer = gets.chomp
    end
    if answer == "1"
      puts "Spouse: Good because that's all we got. Now go get me a chicken!"
    else
      puts "Spouse: Too bad. That's all we have. It'll make do. I belive in you!"
      puts "Spouse: Kinda..."
      puts "Spouse: Just try not to die. I really don't want to get take out."
    end
  end

  def damage
    weapon_damage = @@weapon_arr.index(random_weapon)
    if weapon_attack_damage == 0
      weapon_attack_damage + 2
    else
      weapon_attack_damage * 2
    end
    attack
  end

end

class game(char_name,weapon)
  attr_reader

  def initialize
    @char_name = char_name
    @weapon = weapon
  end

  def story_intro
    puts "Spouse: Hey honey, my in laws are coming over tonight.  Can you please make your famous roast chicken?"
    puts "You: Sure thing!"
    puts "Spouse: Excellent!! Go hunt a chicken from the 'Forest of Apocolyptic Gallus Gallus Domesticus'?"
    puts "You: Um... isn't that the forest that holds the most delicious but DEADLIEST chickens!?!? I hear that they eat humans. I don't know..."
    puts "Spouse: Yeah, so? Don't you love me? Or do I have to remind you of that time when..."
    puts "You: OKAY, OKAY... I will go get you a chicken."
    puts "Spouse: Very well. Take this with you for protection.\n\n"
  end

  def fool_v_chicken_turn
    turn_count = 0
    if turn_count.even?
       #fool class move
    else
      #chicken class move
    turn += 1
  end

  def fool_v_bosschick
    if chicken.health == 0
      puts "You've killed the chicken. Hurray! Wait what's that?! \n
       Oh no, the Boss Chick is here and there is nowhere to go! You must fight her. Godspeed!"
      fool_v_chicken_turn
    end
  end

end

class Fool
  attr_accessor :name
  attr_reader :health

  def initialize(health,name)
    @health = health
    @name = name
    @damage

  def get_char_name(random_weapon)
    puts "Hey, Fool! Yes, you with the #{random_weapon}. What's your name?"
    @name = gets.chomp
  end

  def mocks_name
    puts "Haha. #{@name} is a silly name.\n
    Anyway, good luck on your adventure sucker!"
  end

  include Fight

  def fool_attack_status
    if weapon_damage == 0
      put "Tap!" + attack_damage_count
    elsif weapon_damage == 1
      put "Flop!" + attack_damage_count
    elsif weapon_damage == 2
      put "Splat!" + attack_damage_count
    elsif weapon_damage == 3
      put "Slice!" + attack_damage_count
    else weapon_damage == 4
      put "Bam!" + attack_damage_count
    end
  end

end

class Chicken
  attr_reader :name, :health, :chicken_attack_damage

  def initialize("Chicken Minion", health = 20, chicken_attack_damage = 5)
    @name = "Chicken Minion"
    @health = health
    @chicken_attack_damage = chicken_attack_damage
  end

  def damage
    @chicken_attack_damage
  end

  include Fight

end

class BossChick < Boss
  attr_reader :name, :health, :chicken_attack_damage

  def initialize(#???)
    @name = "Boss Chick"
    @health = health * 5
    @chicken_attack_damage = chicken_attack_damage * 10
    super(health, chicken_attack_damage)
  end

  def special_attack
    rand(1..8) @chicken_damage * 2
    puts "Human fool! You just got shredded with my talons of terror!"
  end

end
