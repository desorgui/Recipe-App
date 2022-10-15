class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Recipe

    return unless user.present?

    can :manage, Food
    can :manage, Recipe, user_id: user.id
    can :manage, RecipeFood do |ingredient|
      user_recipes_ids = user.recipes.map(&:id)

      user_recipes_ids.include? ingredient.recipe_id
    end
    can :manage, Inventory, user_id: user.id

    return unless user.admin?

    can :manage, :all
  end
end
