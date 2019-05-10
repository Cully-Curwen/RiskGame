class User
  attr_reader :id, :name, :colour
  attr_accessor :income
  IDs = []

  def initialize(attr = {})
    @name = attr[:name]
    @colour = attr[:colour]
    attr[:neutral] ? @id = 0 : giveId
    Game.STATE[:users] << self
    Setup.STATE[@id] = false
  end

  def giveId
    puts "giveId called"
    if IDs.empty?
      @id = 1
    else
      temp = IDs.last + 1
      while IDs.include?(temp) do
        temp += 1
      end
      @id = temp
    end
    IDs << @id
    @id
  end

  def setIncome
    puts "setIncome called"
    if Game.STATE[:currentPhase] == "Deployment"
      return @income = Setup.deployIncome
    end
    territories = Game.usersTerritoriesIds
    base = territories.count / 3
    bonus = 0
    territories.select{ |territory| territory.to_s[/^1/]}.count == 4 ? bonus += 2 : bonus # South America +2
    territories.select{ |territory| territory.to_s[/^2/]}.count == 7 ? bonus += 2 : bonus # Europe + 5
    territories.select{ |territory| territory.to_s[/^3/]}.count == 12 ? bonus += 2 : bonus # Asia + 7
    territories.select{ |territory| territory.to_s[/^4/]}.count == 4 ? bonus += 2 : bonus # Australia + 2
    territories.select{ |territory| territory.to_s[/^5/]}.count == 6 ? bonus += 2 : bonus # Africa + 3
    territories.select{ |territory| territory.to_s[/^9/]}.count == 9 ? bonus += 2 : bonus # North America + 5
    return @income = base + bonus
  end

end