# frozen_string_literal: true

module RTanque
  class Gosu
    class Bot
      class Status
        STATUS_BAR_HEIGHT = 3
        STATUS_BAR_WIDTH = 100
        IMAGE = ::Gosu::Image.new(Gosu.resource_path('images/bar.png'))

        # Different status colours as RGB values
        #                      Blue, Green,Red,  Alpha
        FULL_STATUS_COLOUR   = [0x4A, 0xBE, 0x4A, 0xFF].freeze
        MEDIUM_STATUS_COLOUR = [0x00, 0xBE, 0xFF, 0xFF].freeze
        LOW_STATUS_COLOUR    = [0x00, 0x00, 0xDC, 0xFF].freeze

        def initialize(bot, value:)
          @bot = bot
          @value = value
          @y_offset = 5
        end

        def draw
          IMAGE.draw(x, y, ZOrder::BOT_HEALTH, status / 200.0, 0.5, colour)
        end

        private

        def status = @bot.send(@value)
        def x = @bot.x - ((STATUS_BAR_WIDTH / 2) * @bot.x_factor)
        def y = @bot.y + ((@y_offset + RTanque::Bot::RADIUS) * @bot.y_factor)
        def colour = colours.map.with_index { |cs, i| graduated(*cs, percentage) << (8 * i) }.sum
        def graduated(min, max, percentage) = (((max - min) * percentage) + min).round
        def percentage = ((status > 50 ? 100 : 50) - status) / 50

        def colours
          return FULL_STATUS_COLOUR.zip(MEDIUM_STATUS_COLOUR) if status > 50

          MEDIUM_STATUS_COLOUR.zip(LOW_STATUS_COLOUR)
        end
      end
    end
  end
end
