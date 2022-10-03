class RecipesController < ApplicationController

    before_action :authorize

    def index
        recipes = Recipe.all
        render json: recipes, status: :ok
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = Recipe.create(recipe_params)
            render json: recipe, status: :created
        else
            render json: {errors: user.errors.full_messages}, status: :unprocessable_entity
        end
    end
    
    private

    def authorize
        return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete, user_id: user.id)
    end
end