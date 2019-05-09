class User
  attr_reader :id, :name, :colour
  attr_accessor :income
  IDs = []

  def initialize(attr = {})
    @name = attr[:name]
    @colour = attr[:colour]
    attr[:neutral] ? @id = 0 : giveId
    Game.STATE[:users] << self
  end

  def giveId
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

  def income
    ters = Game.usersTerritoriesId
    base = territories.count / 3
    bonus = 0
    ters.select{ |ter| ter[/^1/]}.count == 4 ? bonus += 2 : bonus # South America +2
    ters.select{ |ter| ter[/^1/]}.count == 7 ? bonus += 2 : bonus # Europe + 5
    ters.select{ |ter| ter[/^1/]}.count == 12 ? bonus += 2 : bonus # Asia + 7
    ters.select{ |ter| ter[/^1/]}.count == 4 ? bonus += 2 : bonus # Australia + 2
    ters.select{ |ter| ter[/^1/]}.count == 6 ? bonus += 2 : bonus # Africa + 3
    ters.select{ |ter| ter[/^1/]}.count == 9 ? bonus += 2 : bonus # North America + 5
    Game.STATE[:currentPhase] == "Deployment" ? @income = 2 : @income = base + bonus
  end

end