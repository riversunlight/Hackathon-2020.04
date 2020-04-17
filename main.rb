#ruby -Ku

require 'json'
require_relative './Monochrome-Ruby'
require_relative './scene-eitor'

$enemies_data = open('./data/enemies.json') do |i|
  JSON.load(i)
end
require_relative './data/random-names'
require_relative './data/items'

require_relative './scenes/title'
require_relative './scenes/field'
require_relative './scenes/menu'
require_relative './scenes/shop'
require_relative './scenes/battle'

Scene.new([
  Title,
  Field,
  Menu,
  Shop,
  Battle
])

class Player
  attr_accessor :name, :money, :hp, :max_hp, :mp, :max_mp, :attack, :block, :agility, :item_list
  
  def initialize(name)
    @name = name
    @money = 1000
    @max_hp = 100
    @hp = 100
    @max_mp = 60
    @mp = 60
    @attack = 20
    @block = 10
    @agility = 20
    @item_list = []
  end
end

loop do
  Key.update

  break if Key.down?(Key::ESCAPE) && Scene.current == 0

  # only-develop-key
  Scene.next(init: true) if Key.down?(Key::PAGEUP)
  Scene.back(init: false) if Key.down?(Key::PAGEDOWN)
  Scene.close if Key.down?(Key::K_END)
  # ---

  Scene.update
  Scene.draw
end