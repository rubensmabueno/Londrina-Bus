module API
  module V1
    class SchedulesController < APIController
      before_action :set_routes

      def index
        @routes = @routes.where(day: params[:day_id]) if params[:day_id]

        render json: @routes.first
      end

      def show
        render json: @routes.find(params[:id])
      end

      private

      def set_routes
        @routes = Route.where(
            line_id: params[:line_id], origin_id: params[:origin_id], destination_id: params[:destination_id]
        )
      end
    end
  end
end
