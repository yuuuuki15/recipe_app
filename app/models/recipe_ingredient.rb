class RecipeIngredient
  include ActiveModel::Model
  attr_accessor :title, :image, :amount, :method, :tip, :public_id, :user_id, :name, :quantity

  # レシピモデルのバリデーション
  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :amount, numericality: { other_than: 0, allow_blank: true }
    validates :method, length: { maximum: 1000 }
    validates :public_id
    validates :user_id, numericality: { other_than: 0 }
  end

  validates :tip, length: { maximum: 1000 }
  # 材料モデルのバリデーション
  validates :name, presence: true, length: { maximum: 40 }
  validates :quantity, presence: true


  def save
    recipe = Recipe.create(title: title, image: image, amount: amount, method: method, tip: tip, public_id: public_id, user_id: user_id)
    Ingredient.create(name: name, quantity: quantity, recipe_id: recipe.id)
  end
end