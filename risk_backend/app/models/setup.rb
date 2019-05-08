class Setup

  def self.startGame
    puts "startGame called"
    if checkPlayerCount == false
      return puts "Not Enough Players"
    end
    randomStart
    Game.STATE[:currentPhase] = "Setup - Deployment"
    Game.STATE[:currentPlayer] = Game.STATE[:users].sample
    while Game.STATE[:currentPlayer].id == 0 do
      Game.STATE[:currentPlayer] = Game.STATE[:users].sample
    end
    puts "startGame completed"
  end

  def self.checkPlayerCount
    puts "checkPlayerCount called"
    case  Game.STATE[:users].count
    when 0, 1 
      return false
    when  2
      User.new(id: 0, name: "Neutral", colour: "#B1B4B8")
      return true
    else
      return true
    end
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
    Game.actionTick
  end

end