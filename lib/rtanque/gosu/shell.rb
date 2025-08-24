# frozen_string_literal: true

require 'gosu'

module RTanque
  class Gosu
    class Shell
      attr_reader :shell

      IMAGE = ::Gosu::Image.new(Gosu.resource_path('images/bullet.png'))
      DEBUG = ENV.fetch('DEBUG_SHELLS', nil)

      def initialize(window, shell)
        @window = window
        @shell = shell
        @x0 = shell.position.x
        @y0 = @window.height - shell.position.y
      end

      def draw
        return debug_draw if DEBUG

        position = [shell.position.x, @window.height - shell.position.y]
        IMAGE.draw_rot(position[0], position[1], ZOrder::SHELL, 0, 0.5, 0.5)
      end

      private

      def debug_draw
        white = ::Gosu::Color::WHITE
        pos = shell.position
        x1 = pos.x
        y1 = @window.height - pos.y
        @window.draw_line @x0, @y0, white, x1, y1, white, ZOrder::SHELL
      end
    end
  end
end
