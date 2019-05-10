class Redeployment

  LOCK = []

  def self.LOCK
    LOCK
  end

  def self.LOCK_reset
    LOCK.clear
  end

  def self.findTerritory(id)
    Game.STATE[:territories].find{ |territory| territory.id == id }
  end

  def self.redeploy(start_id, end_id, armies)
    if LOCK.include?(start_id)
      return 1
    end
    startTer = findTerritory(start_id)
    endTer = findTerritory(end_id)
    startTer.armies -= armies
    endTer.armies += armies
    LOCK << end_id
    return 1
  end

end