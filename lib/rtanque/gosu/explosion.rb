# frozen_string_literal: true

require 'gosu'

module RTanque
  class Gosu
    class Explosion
      FRAMES = (1..71).map { |i| ::Gosu::Image.new(Gosu.resource_path("images/explosions/explosion2-#{i}.png")) }

      def initialize(window, explosion)
        @explosion = explosion
        @position = [explosion.position.x, window.height - explosion.position.y]
      end

      def draw
        frame.draw_rot(@position[0], @position[1], 5, ZOrder::EXPLOSION)
      end

      private

      def frame = FRAMES[(@explosion.percent_dead * frames_length).floor]
      def frames_length = @frames_length ||= FRAMES.length - 1
    end
  end
end
