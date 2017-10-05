

class Station

  def initialize(name, zone)
    @name = name
    @zone = zone
    @info = {}
  end

  def info
    @info[:name] = @name
    @info[:zone] = @zone
    @info
  end

end
