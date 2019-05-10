class Setup

  STATE = {}
  READY = []

  def self.STATE
    STATE
  end

  def self.READY
    READY
  end

  def self.readyUp(user_id, ready)
    puts "readUp called"
    Setup.STATE[user_id] = ready
    Setup.playersReady
  end

  def self.playersReady
    puts "playersRead called"
    if Game.STATE[:users].count == Setup.STATE.values.count
      if !Setup.STATE.values.include?(false)
        Setup.startGame
      else
        return 1
      end
    else
      puts "player count error: Game.STATE[:users] == Setup.STATE.values"
      return 2
    end
  end

  def self.startGame
    puts "startGame called"
    if checkPlayerCount == false
      return puts "Not Enough Players"
    end
    Setup.randomStart
    Game.STATE[:currentPhase] = "Deployment"
    Setup.goesFirst
    Game.STATE[:live] = true
    puts "startGame completed"
    return 0
  end
  
  def self.goesFirst
    puts "goesFirst called"
    Game.STATE[:currentPlayer] = Game.STATE[:users].sample
    while Game.STATE[:currentPlayer].id == 0 do
      Game.STATE[:currentPlayer] = Game.STATE[:users].sample
    end
    Game.STATE[:currentPlayer].setIncome
  end

  def self.checkPlayerCount
    puts "checkPlayerCount called"
    case  Game.STATE[:users].count
    when 0, 1 
      return false
    when  2
      User.new(neutral: true, name: "Neutral", colour: "#B1B4B8")
      Game.STATE[:users].map{ |user| STATE[user.id] = 40 }
    when 3
      Game.STATE[:users].map{ |user| STATE[user.id] = 35 }
    when 4
      Game.STATE[:users].map{ |user| STATE[user.id] = 30 }
    when 5
      Game.STATE[:users].map{ |user| STATE[user.id] = 25 }
    when 6
      Game.STATE[:users].map{ |user| STATE[user.id] = 20 }
    end
    return true
  end

  def self.randomStart
    puts "randomStart called"
    unowned = Territory.CODES
    unowned.shuffle!
    while !unowned.empty?
      Game.STATE[:users].map do |user|
        Territory.new(id: unowned.shift, owner: user, armies: 1)
        STATE[user.id] -= 1 
      end
    end
    puts "Setup.STATE: #{STATE}"
    Game.STATE[:territories].sort!{ |a, b| a.id <=> b.id }
  end

  def self.deploy(territory_id, armies)
    puts "deploy called"
    currentPlayer = Game.STATE[:currentPlayer]
    armies <= currentPlayer.income ? armies : armies = currentPlayer.income
    territories = Game.usersTerritoriesIds
    if territories.include?(territory_id)
      Setup.placeTroops(territory_id, armies)
      currentPlayer.income -= armies
      code = 0
    else
      code = 1
    end
    if currentPlayer.income == 0
      Game.nextPlayer
    end
    return code
  end
  
  def self.deployIncome
    puts "deployIncome called"
    currentPlayer = Game.STATE[:currentPlayer]
    if STATE[currentPlayer.id] > 1
      income = 2
      STATE[currentPlayer.id] -= 2
    elsif STATE[currentPlayer.id] == 1
      income = 1
      STATE[currentPlayer.id] -= 1
    elsif STATE[currentPlayer.id] == 0
      STATE.values.reduce(:+) == 0 ? Game.nextPhase : Game.nextPlayer
    end
    return income
  end
  
  def self.placeTroops(territory_id, armies)
    puts "placeTroops called"
    Game.STATE[:territories].find{ |territory| territory.id == territory_id }.armies += armies
  end
  
  def self.neutralDeploy
    puts "neutralDeploy called"
    armies = Game.STATE[:currentPlayer].income
    territories = Game.usersTerritoriesIds
    placeTroops(territories.sample, armies)
    Game.STATE[:currentPlayer].income = 0
  end

  def self.fullStartBoard
    puts "fullStartBoard called"
    Game.neutralTurn
    check = Setup.STATE.values.reduce(:+)
    while check > 0 do
      index = Game.STATE[:users].find_index{|user| user == Game.STATE[:currentPlayer]} + 1
      if index == Game.STATE[:users].length
        index = 0
      end
      Game.STATE[:currentPlayer] = Game.STATE[:users][index]
      Game.STATE[:currentPlayer].income = Setup.STATE[Game.STATE[:currentPlayer].id]
      Setup.STATE[Game.STATE[:currentPlayer].id] = 0
      Game.neutralTurn
      check = Setup.STATE.values.reduce(:+)
    end
    puts "Setup.STATE: #{STATE}"
    Game.nextPhase
    puts "fullStartBoard complete"
  end

end