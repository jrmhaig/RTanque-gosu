module RTanque
  class Gosu
    def initialize match
      @window = RTanque::Gosu::Window.new match
    end

    def run
      trap(:INT) { window.close }
      @window.show
    end

    RESOURCE_DIR = File.expand_path('../../../resources', __FILE__)
    def self.resource_path(*components)
      File.join(RESOURCE_DIR, *components)
    end

    module ZOrder
      BACKGROUND = -1
      BOT_HEALTH = 5
      BOT_NAME = 6
      BOT_BODY = 7
      BOT_TURRET = 8
      BOT_RADAR = 9
      SHELL = 10
      EXPLOSION = 20
    end
  end
end

require 'rtanque/gosu/draw_group'
require 'rtanque/gosu/window'
require 'rtanque/gosu/bot'
require 'rtanque/gosu/shell'
require 'rtanque/gosu/explosion'
