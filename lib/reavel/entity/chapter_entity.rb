module Reavel
  module Entity
    class ChapterEntity
      attr_accessor :title, :children

      def initialize(title:, children: [])
        @title = title
        @children = children
      end
    end
  end
end
