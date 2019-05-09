class Combatant
  attr_reader :user, :territory_id
  attr_accessor :armies, :casualties, :dice

  def initialize(user, territory_id, armies)
    @user = user
    @territory_id = territory_id
    @armies = armies
    @casualties = 0
    @dice = []
  end

  def rollDice(times)
    puts "rollDice called"
    @dice = []
    while times > 0 do
      @dice << rand(1..6)
      times -= 1
    end
  end

  def casualty
    puts "casualty called"
    self.armies -= 1
    self.casualties += 1
  end

end