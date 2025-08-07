# frozen_string_literal: true

require 'gosu'

module RTanque
  class Gosu
    class Window < ::Gosu::Window
      UPDATE_INTERVAL = Configuration.gui.update_interval
      FONT_NAME = ::Gosu.default_font_name
      SMALL_FONT_SIZE = Configuration.gui.fonts.small

      def initialize(match)
        @match = match
        @arena = match.arena
        match.bots.each { |bot| bot.gui_window = self }
        # Fullscreen: https://github.com/jlnr/gosu/issues/159#issuecomment-12473172
        super(@arena.width, @arena.height, false, UPDATE_INTERVAL)
        self.caption = self.class.name.split('::').first

        @draw_procs = []
      end

      def update
        @match.tick
      end

      def draw
        close if button_down?(::Gosu::Button::KbEscape)
        background.draw(0, 0, ZOrder::BACKGROUND)
        if @match.finished?
          close if Configuration.quit_when_finished
          gui_bots.each { |bot| bot.grow(2) }
        end
        draw_drawables
      end

      def draw_drawables
        gui_bots.draw
        gui_shells.draw
        gui_explosions.draw

        @draw_procs.each do |proc|
          proc.call self
        end

        @draw_procs.clear
      end

      def add_draw_proc(&block)
        @draw_procs << block
      end

      def gui_bots
        @gui_bots ||= DrawGroup.new(@match.bots) do |bot|
          RTanque::Gosu::Bot.new(self, bot)
        end
      end

      def gui_shells
        @gui_shells ||= DrawGroup.new(@match.shells) do |shell|
          RTanque::Gosu::Shell.new(self, shell)
        end
      end

      def gui_explosions
        @gui_explosions ||= DrawGroup.new(@match.explosions) do |explosion|
          RTanque::Gosu::Explosion.new(self, explosion)
        end
      end

      private

      def background
        @background ||= ::Gosu::Image.new(Gosu.resource_path('images/grass.png'))
      end
    end
  end
end
