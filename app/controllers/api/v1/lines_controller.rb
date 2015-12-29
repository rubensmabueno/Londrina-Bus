module API
  module V1
    class LinesController < APIController
      def index
        render json: Line.all
      end

      def show
        render json: Line.find(params[:id])
      end
    end
  end
end
