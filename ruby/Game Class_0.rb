#Chicken Game
module Killable


def story_intro
  puts "Spouse: Hey honey, my in laws are coming over tonight.  Can you please make your famous roast chicken?"
  puts "You: Sure thing!"
  puts "Spouse: Excellent!! Can you please hunt a chicken from the 'Forest of Apocolyptic Gallus Gallus Domesticus'?"
  puts "You: Um... isn't that the forest that holds the most delicious but DEADLIEST chickens!?!? I hear that they eat humans. I don't know..."
  puts "Spouse: Yeah, so? Don't you love me? Or do I have to remind you of that time where..."
  puts "You: OKAY, OKAY... I will go get you a chicken."
  puts "Spouse: Very well. Take this with you for protection.\n\n"
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
    until answer == 1 || answer == 2 #try regex
      puts "Spouse: So you are about to hunt a human eating chicken but you can't pick the correct number? I worry about you."
      puts "Spouse: Select '1' for keep or '2' to get a different one."
      answer = gets.chomp
    end
    if answer == 1
      puts "Spouse: Good because that's all we got. Now go get me a chicken!"
    else
      puts "Spouse: Too bad. That's all we have. It'll make do. I belive in you!"
      puts "Spouse: Kinda..."
      puts "Just try not to die. I really don't want to get take out."
    end
  end
  def damage
    weapon_damage = @@weapon_arr.index(random_weapon)
    if weapon_damage == 0
      weapon_damage + 2
    else
      weapon_damage * 2
    end
    special_damage(weapon_damage)
    attack
  end

  def special_damage(weapon_damage)
    special = weapon_damage * 5
    rand(special 1..5) #taking turns...
  end

end

class game(char_name,weapon)
  attr_reader

  def initialize
    @char_name = char_name
    @weapon = weapon
  end

  def victory? #game class?
    if Chicken.health ==0 && BossChick.health == 0
      puts "You've won and killed the boss of all chickens! Now go home and cook that chicken. It's so worth it."
    elsif Fool.health == 0
      puts "You are dead. The chickens will have a feast tonight. You are such a dissappointment."
    else
      return false
    end
  end

end

class Fool
  attr_reader

  def initialize(health)
    @health = health
    @name = name

  def get_char_name(random_weapon)
    puts "Hey, Fool! Yes, you with the #{random_weapon}. What's your name?"
    @name = gets.chomp
  end

  def mocks_name
    puts "Haha. #{@name} is a silly name.\n
    Anyway, good luck on your adventure sucker"
  end

  def attack
    enemy_damage = other.health -= damage
    attack_status
  end

  def attack_damage_count #game class...
    puts "-#{damage} damage! That #{other.name} has #{other.health} health left!"
  end

  def attack_status
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

  def dodge
    other.attacks
    rand(1..5)
  end

end

class Chicken
  attr_reader :name, :health, :chicken_damage
  def initialize(name, health = 100, chicken_damage = 10)
    @name = name
    @health = health
    @chicken_damage = chicken_damage

  def name
    @name = "Chick"
  end
end

class BossChick < Boss
  def initialize(health)
    @chicken_damage = chicken_damage * 50
    super(health, chicken_damage = 20)

  def special_attack
    rand(1..8) @chicken_damage * 2
  end
end
