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
    order ? attack : withdraw
  end

  def self.attack(defenderTerritory_id, attackerTerritory_id, attackerArmies)
    puts "attack called"
    if LOCK.include?(attackerTerritory_id)
      return 1
    end
    battle = Game.STATE[:liveBattle] |= Battle.new(defenderTerritory_id, attackerTerritory_id, attackerArmies)
    battle.attackDice
    battle.defendDice
    battle.casualties
    battle.battleRound += 1
    return 0
  end

  def self.withdraw
    puts "withdraw called"
    battle = Game.STATE[:liveBattle]
    atckTer = Game.STATE[:territories].find{ |ter| ter.id == battle.attacker.territory_id }
    atckTer.armies += battle.attacker.armies
    defTer = Game.STATE[:territories].find{ |ter| ter.id == battle.defender.territory_id }
    defTer.armies += battle.defender.armies
    LOCK << battle.attacker.territory_id
  end
  
  def self.victory
    puts "victory called"
    battle = Game.STATE[:liveBattle]
    territory = Game.STATE[:territories].find{ |territory| territory.id == battle.defender.territory_id }
    territory.owner = Game.STATE[:currentPlayer]
    territory.armies = battle.attacker.armies
    LOCK << battle.attacker.territory_id
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
    @attacker.dice.sort!{ |a, b| a <=> b }
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
    @defender.dice.sort!{ |a, b| a <=> b }
  end
  
  def casualties
    puts "casualties called"
    num = @attacker.dice.count < @defender.dice.count ? @attacker.dice.count : @defender.dice.count
    puts "atckD:#{@attacker.dice}, dnfD:#{@defender.dice}"
    while num > 0 do
      @attacker.dice[num] > @defender.dice[num] ? @defender.casualty : @attacker.casualty
      self.validate
      num -= 1
    end
  end

  def validate
    puts "validate called"
    if @attacker.armies == 0
      Battle.withdraw
    end
    if @defender.armies == 0
      Battle.victory
    end
  end

end