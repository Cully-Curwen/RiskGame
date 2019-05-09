require 'json'

class  Game
  STATE = {
    users: [],
    territories: [],
    liveBattle: nil,
    turn: 0,
    currentPlayer: nil,
    currentPhase: nil,
    live: false
  }
  PLAYER_TURNS = {count: -1}

  def self.STATE 
    STATE
  end

  def self.PLAYER_TURNS
    PLAYER_TURNS
  end

  def self.gameState
    STATE.to_json
  end

  def self.nextPlayer
    puts "nextPlayer called"
    index = STATE[:users].find_index{|user| user == STATE[:currentPlayer]} + 1
    if index == STATE[:users].length
      index = 0
    end
    STATE[:currentPlayer] = STATE[:users][index]
    lockReset
    STATE[:currentPlayer].setIncome
    if STATE[:currentPlayer].id == 0
      Game.STATE[:currentPhase] == "Deployment" ? Setup.neutralDeploy : neutralTurn
      nextPlayer
    end
  end
  
  def self.neutralTurn
    puts "neutralTurn called"
    armies = STATE[:currentPlayer].income
    while armies > 0 do
      usersTerritories.sample.armies += 1
      armies -= 1
    end
  end

  def self.usersTerritories
    puts "usersTerritories called"
    STATE[:territories].filter{ |ter| ter.owner.id == STATE[:currentPlayer].id }
  end
  
  def self.usersTerritoriesIds
    puts "usersTerritoriesIds called"
    usersTerritories.map{ |ter| ter.id }
  end

  def self.nextPhase
    puts "nextPhase called"
    case STATE[:currentPhase]
    when "Deployment"
      STATE[:currentPhase] = "Reinforcement"
      endTurn
    when "Reinforcement"
      STATE[:currentPhase] = "Battle"
    when "Battle"
      STATE[:currentPhase] = "Redeployment"
    when "Redeployment"
      STATE[:currentPhase] = "Reinforcement"
    end
  end

  def self.endTurn
    puts "endTurn called"
    PLAYER_TURNS[:count] += 1
    STATE[:turn] = (PLAYER_TURNS[:count] / STATE[:users].count) + 1
    nextPlayer
  end

  def self.lockReset
    Battle.LOCK = []
    Redeploy.LOCK = []
  end

end 