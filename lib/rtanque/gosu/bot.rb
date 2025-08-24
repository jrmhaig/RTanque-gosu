# frozen_string_literal: true

require 'gosu'
require 'forwardable'
require 'rtanque/gosu/bot/status'

module RTanque
  class Gosu
    class Bot
      extend Forwardable

      def_delegators :@bot, :health, :name

      attr_reader :bot, :x_factor, :y_factor

      def initialize(window, bot)
        @window = window
        @bot = bot
        @body_image = ::Gosu::Image.new(Gosu.resource_path('images/body.png'))
        @turret_image = ::Gosu::Image.new(Gosu.resource_path('images/turret.png'))
        @radar_image = ::Gosu::Image.new(Gosu.resource_path('images/radar.png'))
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
        @body_image.draw_rot(x, y, ZOrder::BOT_BODY, @bot.heading.to_degrees, 0.5, 0.5, @x_factor, @y_factor)
        @turret_image.draw_rot(x, y, ZOrder::BOT_TURRET, @bot.turret.heading.to_degrees, 0.5, 0.5, @x_factor, @y_factor)
        @radar_image.draw_rot(x, y, ZOrder::BOT_RADAR, @bot.radar.heading.to_degrees, 0.5, 0.5, @x_factor, @y_factor)
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
