class Favorites
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def total_count
    @contents.values.sum
  end

  def add_pet(id)
    @contents[id.to_s] = count_of(id) + 1
  end

  def count_of(id)
    @contents[id.to_s].to_i
  end

  def favorite_pets
    acc = @contents.keys.map{|str| str.to_i}
    acc.map{|num| Pet.find(num)}
  end

  def selection_form_ready
    favorite_pets.map.with_index{|pet, index| [pet.name, index+1]}
  end

  def delete_all
    @contents.clear
  end

end
