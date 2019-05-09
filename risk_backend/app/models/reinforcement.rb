class Reinforcement

  def self.reinforce(territory_id, armies)
    puts "reinfroce called"
    currentPlayer = Game.STATE[:currentPlayer]
    armies <= currentPlayer.income ? armies : armies = currentPlayer.income
    territories = Game.usersTerritoriesIds
    if territories.include?(territory_id)
      Reinforcement.placeTroops(territory_id, armies)
      currentPlayer.income -= armies
      code = 0
    else
      code = 1
    end
    if currentPlayer.income == 0
      Game.nextPhase
    end
    return code
  end

  def self.placeTroops(territory_id, armies)
    puts "placeTroops called"
    Game.STATE[:territories].find{ |territory| territory.id == territory_id }.armies += armies
  end
end