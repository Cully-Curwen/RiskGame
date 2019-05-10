class Battle
  attr_reader :attacker, :defender
  attr_accessor :battleRound

  LOCK = []

  def initialize(defenderTerritory_id, attackerTerritory_id, attackerArmies)
    createAttacker(attackerTerritory_id, attackerArmies)
    createDefender(defenderTerritory_id)
    @battleRound = 0
    Game.STATE[:liveBattle] = self
  end

  def self.LOCK
    LOCK
  end

  def self.LOCK_reset
    LOCK.clear
  end
  
  def createAttacker(territory_id, armies)
    puts "createAttacker called"
    user = Game.STATE[:currentPlayer]
    territory = Game.STATE[:territories].find{ |territory| territory.id == territory_id }
    territory.armies -= armies
    @attacker = Combatant.new(user, territory_id, armies)
  end
  
  def createDefender(territory_id)
    puts "createDefender called"
    territory = Game.STATE[:territories].find{ |territory| territory.id == territory_id }
    user = territory.owner
    armies = territory.armies
    @defender = Combatant.new(user, territory_id, armies)
  end

  def self.continueAttack(order)
    puts "continueAttack called"
    order ? Battle.logic : Battle.withdraw
  end

  def self.attack(base_territory_id, target_territory_id,  armies)
    puts "attack called"
    attackerTerritory_id = base_territory_id
    defenderTerritory_id = target_territory_id
    attackerArmies = armies
    if LOCK.include?(attackerTerritory_id)
      puts "attack complete"
      return 1
    end
    if !Game.STATE[:liveBattle]
      Battle.new(defenderTerritory_id, attackerTerritory_id, attackerArmies)
    end
    Battle.logic
    puts "attack complete"
    return 0
  end

  def self.logic
    puts "logic called"
    battle = Game.STATE[:liveBattle]
    battle.attackDice
    battle.defendDice
    battle.casualties
    battle.battleRound += 1
  end

  def self.withdraw
    puts "withdraw called"
    battle = Game.STATE[:liveBattle]
    atckTer = Game.STATE[:territories].find{ |ter| ter.id == battle.attacker.territory_id }
    atckTer.armies += battle.attacker.armies
    defTer = Game.STATE[:territories].find{ |ter| ter.id == battle.defender.territory_id }
    defTer.armies -= battle.defender.casualties
    LOCK << battle.attacker.territory_id
    Game.STATE[:liveBattle] = nil
  end
  
  def self.victory
    puts "victory called"
    battle = Game.STATE[:liveBattle]
    territory = Game.STATE[:territories].find{ |territory| territory.id == battle.defender.territory_id }
    territory.owner = Game.STATE[:currentPlayer]
    territory.armies = battle.attacker.armies
    LOCK << battle.attacker.territory_id
    LOCK << battle.defender.territory_id
    Game.STATE[:liveBattle] = nil
  end
  
  def attackDice
    puts "attackDice called"
    # attacker = Game.STATE[:liveBattle][:attacker]
    armies = @attacker.armies
    case armies
    when 1
      @attacker.rollDice(1)
    when 2
      @attacker.rollDice(2)
    else
      @attacker.rollDice(3)
    end
    @attacker.dice.sort!{ |a, b| b <=> a }
  end
  
  def defendDice
    puts "defendDice called"
    # defender = Game.STATE[:liveBattle][:defender]
    armies = @defender.armies
    case armies
    when 1
      @defender.rollDice(1)
    else
      @defender.rollDice(2)
    end
    @defender.dice.sort!{ |a, b| b <=> a }
  end
  
  def casualties
    puts "casualties called"
    num = @attacker.dice.count < @defender.dice.count ? @attacker.dice.count : @defender.dice.count
    puts "atckD:#{@attacker.dice}, dnfD:#{@defender.dice}"
    while num > 0 do
      index = num - 1
      @attacker.dice[index] > @defender.dice[index] ? @defender.casualty : @attacker.casualty
      self.validate
      num -= 1
    end
  end

  def validate
    puts "validate called"
    puts "attack: #{@attacker.armies}, defender: #{@defender.armies}"
    if @attacker.armies == 0
      Battle.withdraw
    end
    if @defender.armies == 0
      Battle.victory
    end
  end

end