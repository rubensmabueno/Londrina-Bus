module API
  module V1
    class DestinationsController < APIController
      before_action :set_routes

      def index
        @routes = @routes.where(day: params[:day_id]) if params[:day_id]
        destinations_id = @routes.select(:destination_id).distinct

        destinations = Stop.find(destinations_id.map(&:destination_id))

        render json: destinations
      end

      def show
        render json: @routes.find_by(destination_id: params[:id])
      end

      private

      def set_routes
        @routes = Route.where(line_id: params[:line_id], origin_id: params[:origin_id])
      end
    end
  end
end
