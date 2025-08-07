# frozen_string_literal: true

module RTanque
  class Gosu
    class DrawGroup
      include Enumerable

      def initialize(tick_group, &create_drawable)
        @tick_group = tick_group
        @mapped_drawables = Hash.new do |h, tickable|
          h[tickable] = create_drawable.call(tickable)
        end
      end

      def each(&block)
        @tick_group.each do |tickable|
          if tickable.dead?
            @mapped_drawables.delete(tickable)
          else
            # This invokes @mapped_drawables's block if tickable not already in the hash
            block.call(@mapped_drawables[tickable])
          end
        end
      end

      def draw
        each(&:draw)
      end
    end
  end
end
