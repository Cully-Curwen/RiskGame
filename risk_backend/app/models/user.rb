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

end