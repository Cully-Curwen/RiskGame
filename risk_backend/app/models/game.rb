require 'json'

class  Game
  STATE = {
    users: [],
    territories: [],
    liveBattle: nil,
    turn: 0,
    currentPlayer: nil,
    currentPhase: nil,
  }
  LIVE = false

  def self.STATE 
    STATE
  end

  def self.gameState
    STATE.to_json
  end

  def self.nextPlayer
    puts "nextPlaye called"
    index = STATE[:users].find_index{|user| user == STATE[:currentPlayer]} + 1
    if index == STATE[:users].length
      index = 0
    end
    STATE[:currentPlayer] = STATE[:users][index]
    if STATE[:currentPlayer].id == 0
      neutralTurn
      nextPlayer
    end
  end

  def self.neutralTurn
    armies = STATE[:currentPlayer].income
    while armies > 0 do
      usersTerritories.sample.armies += 1
      armies -= 1
    end
  end

  def self.usersTerritories
    STATE[:territories].filter{ |ter| ter.owner.id == STATE[:currentPlayer].id }
  end

end 