class Territory
  attr_reader :id
  attr_accessor :owner, :armies

  COUNT = 42

  def initialize (attr = {})
    @id = attr[:id]
    @owner = attr[:owner]
    @armies = attr[:armies]
    Game.STATE[:territories] << self
  end

  def self.COUNT
    COUNT
  end

end