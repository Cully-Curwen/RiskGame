require 'json'

class  Game
  STATE = {
    users: [],
    territories: [],
    liveBattle: nil,
    turn: 0,
    actionCount: 0,
    currentPlayer: nil,
    currentPhase: nil,
  }

  def self.STATE 
    STATE
  end

  def self.gameState
    STATE.to_json
  end

  def self.startGame
    puts "startGame called"
    if checkPlayerCount == false
      return puts "Not Enough Players"
    end
    randomStart
    STATE[:currentPhase] = "Setup - Deployment"
    STATE[:currentPlayer] = STATE[:users].sample
    nextPlayer
    puts "startGame completed"
  end

  def self.checkPlayerCount
    puts "checkPlayerCount called"
    case  STATE[:users].count
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
      STATE[:users].map do |user|
        Territory.new(id: unowned.shift, owner: user, armies: 2)
      end
    end
  end

  def self.nextPlayer
    puts "nextPlaye called"
    index = STATE[:users].find_index{|user| user == STATE[:currentPlayer]} + 1
    if index == STATE[:users].length
      index = 0
    end
    STATE[:currentPlayer] = STATE[:users][index]
    if STATE[:currentPlayer].id == 0
      nextPlayer
    end
  end

end 