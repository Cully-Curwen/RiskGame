class User
  attr_reader :id, :name, :colour
  attr_accessor :income

  def initialize(attr = {})
    @id = attr[:id]
    @name = attr[:name]
    @colour = attr[:colour]
    Game.STATE[:users] << self
  end

end