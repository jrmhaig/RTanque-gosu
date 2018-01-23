require 'gosu'

module RTanque
  class Gosu
    class Window < ::Gosu::Window
      UPDATE_INTERVAL = Configuration.gui.update_interval
      FONT_NAME = ::Gosu::default_font_name
      SMALL_FONT_SIZE = Configuration.gui.fonts.small

      attr_reader :gui_bots, :gui_shells, :gui_explosions

      def initialize(match)
        @match = match
        @arena = match.arena
        match.bots.each { |bot| bot.gui_window = self }
        @gui_bots = DrawGroup.new(match.bots) do |bot|
          RTanque::Gosu::Bot.new(self, bot)
        end
        @gui_shells = DrawGroup.new(match.shells) do |shell|
          RTanque::Gosu::Shell.new(self, shell)
        end
        @gui_explosions = DrawGroup.new(match.explosions) do |explosion|
          RTanque::Gosu::Explosion.new(self, explosion)
        end
        # Fullscreen: https://github.com/jlnr/gosu/issues/159#issuecomment-12473172
        super(@arena.width, @arena.height, false, UPDATE_INTERVAL)
        self.caption = self.class.name.split('::').first
        @background = ::Gosu::Image.new(self, Gosu.resource_path("images/grass.png"))

        @draw_procs = []
      end

      def update
        @match.tick
      end

      def draw
        self.close if button_down?(::Gosu::Button::KbEscape)
        @background.draw(0, 0, ZOrder::BACKGROUND)
        if @match.finished?
          self.close if Configuration.quit_when_finished
          self.gui_bots.each { |bot| bot.grow(2) }
        end
        self.draw_drawables
      end

      def draw_drawables
        self.gui_bots.draw
        self.gui_shells.draw
        self.gui_explosions.draw

        @draw_procs.each do |proc|
          proc.call self
        end

        @draw_procs.clear
      end

      def add_draw_proc &b
        @draw_procs << b
      end
    end
  end
end
