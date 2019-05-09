class Territory
  attr_reader :id
  attr_accessor :owner, :armies

  CODES = 42

  def initialize (attr = {})
    @id = attr[:id]
    @owner = attr[:owner]
    @armies = attr[:armies]
    Game.STATE[:territories] << self
  end

  def self.CODES
    CODES
  end

end