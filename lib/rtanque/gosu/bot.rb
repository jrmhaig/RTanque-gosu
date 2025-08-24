# frozen_string_literal: true

require 'gosu'
require 'forwardable'
require 'rtanque/gosu/bot/status'

module RTanque
  class Gosu
    class Bot
      extend Forwardable

      BODY_IMAGE = ::Gosu::Image.new(Gosu.resource_path('images/body.png'))
      TURRET_IMAGE = ::Gosu::Image.new(Gosu.resource_path('images/turret.png'))
      RADAR_IMAGE = ::Gosu::Image.new(Gosu.resource_path('images/radar.png'))

      def_delegators :@bot, :health, :name

      attr_reader :bot, :x_factor, :y_factor

      def initialize(window, bot)
        @window = window
        @bot = bot
        @name_font = ::Gosu::Font.new(@window, Window::FONT_NAME, Window::SMALL_FONT_SIZE)
        @health = Bot::Status.new(self, value: :health)
        @x_factor = 1
        @y_factor = 1
      end

      def draw
        draw_bot
        draw_name
        @health.draw
      end

      def grow(factor = 2, step = 0.002)
        @x_factor += step unless @x_factor > factor
        @y_factor += step unless @y_factor > factor
      end

      def draw_bot
        BODY_IMAGE.draw_rot(x, y, ZOrder::BOT_BODY, @bot.heading.to_degrees, 0.5, 0.5, @x_factor, @y_factor)
        TURRET_IMAGE.draw_rot(x, y, ZOrder::BOT_TURRET, @bot.turret.heading.to_degrees, 0.5, 0.5, @x_factor, @y_factor)
        RADAR_IMAGE.draw_rot(x, y, ZOrder::BOT_RADAR, @bot.radar.heading.to_degrees, 0.5, 0.5, @x_factor, @y_factor)
      end

      def draw_name
        @name_font.draw_text_rel(bot.name, x, y + (RTanque::Bot::RADIUS * @y_factor) + Window::SMALL_FONT_SIZE.to_i,
                                 ZOrder::BOT_NAME, 0.5, 0.5, @x_factor, @y_factor)
      end

      def x = @bot.position.x
      def y = @window.height - @bot.position.y
    end
  end
end
