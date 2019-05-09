class Territory
  attr_reader :id
  attr_accessor :owner, :armies

  CODES = [91, 92, 93, 94, 95, 96, 97, 98, 99, 14, 12, 13, 11, 21, 22, 23, 24, 25, 26, 27, 31, 32, 33, 34, 35, 36, 37, 38, 39, 310, 311, 312, 41, 42, 43, 44, 51, 52, 53, 54, 55, 56]

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