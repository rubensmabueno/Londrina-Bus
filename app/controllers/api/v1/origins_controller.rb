module API
  module V1
    class OriginsController < APIController
      before_action :set_routes

      def index
        @routes = @routes.where(day: params[:day_id]) if params[:day_id]
        origins_id = @routes.select(:origin_id).distinct

        origins = Stop.find(origins_id.map(&:origin_id))

        render json: origins
      end

      def show
        render json: @routes.find_by(origin_id: params[:id])
      end

      private

      def set_routes
        @routes = Route.where(line_id: params[:line_id])
      end
    end
  end
end
