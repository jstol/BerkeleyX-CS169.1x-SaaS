class Dessert
	attr_accessor :name,:calories

  def initialize(name, calories)
    @name = name
		@calories = calories
  end
  
  def healthy?
    return true if (@calories < 200)
		return false
  end
  
  def delicious?
    return true
  end
end

class JellyBean < Dessert
	attr_accessor :flavor

  def initialize(name, calories, flavor)
    super(name, calories)
		@flavor = flavor
  end
  
  def delicious?
    return false if (@flavor == 'black licorice')
		super
  end
end
