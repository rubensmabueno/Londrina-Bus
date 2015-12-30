module API
  module V1
    class PositionsController < APIController
      before_action :set_line

      def index
        render json: @line.positions.to_json
      end

      private

      def set_line
        @line = Line.find(params[:line_id])
      end
    end
  end
end
