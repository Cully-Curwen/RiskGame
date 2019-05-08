class Setup

  STATE = []

  def self.STATE
    STATE
  end

  def self.startGame
    puts "startGame called"
    if checkPlayerCount == false
      return puts "Not Enough Players"
    end
    randomStart
    Game.STATE[:currentPhase] = "Setup - Deployment"
    goesFirst
    puts "startGame completed"
  end
  
  def self.goesFirst
    puts "goesFirst called"
    Game.STATE[:currentPlayer] = Game.STATE[:users].sample
    while Game.STATE[:currentPlayer].id == 0 do
      Game.STATE[:currentPlayer] = Game.STATE[:users].sample
    end
  end

  def self.checkPlayerCount
    puts "checkPlayerCount called"
    case  Game.STATE[:users].count
    when 0, 1 
      return false
    when  2
      User.new(id: 0, name: "Neutral", colour: "#B1B4B8")
      Game.STATE[:users].map{ |user| STATE << {user.id => 40} }
    when 3
      Game.STATE[:users].map{ |user| STATE << {user.id => 35} }
    when 4
      Game.STATE[:users].map{ |user| STATE << {user.id => 30} }
    when 5
      Game.STATE[:users].map{ |user| STATE << {user.id => 25} }
    when 6
      Game.STATE[:users].map{ |user| STATE << {user.id => 20} }
    end
    return true
  end

  def self.randomStart
    puts "randomStart called"
    unowned = (1..Territory.COUNT).to_a
    unowned.shuffle!
    while !unowned.empty?
      Game.STATE[:users].map do |user|
        Territory.new(id: unowned.shift, owner: user, armies: 2)
      end
    end
    Game.STATE[:territories].sort!{ |a, b| a.id <=> b.id }
  end

  def self.placeTroops(territory_id, armies)
    Game.STATE[:territories].find{ |tet| ter.id == territory_id }.armies = armies
  end

end