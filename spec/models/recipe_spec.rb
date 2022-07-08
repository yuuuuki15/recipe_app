require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @recipe = FactoryBot.build(:recipe)
  end

  describe 'レシピ投稿' do
    context 'レシピ投稿がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@recipe).to be_valid
      end

      it '画像が空でも保存できること' do
        @recipe.image = nil
        expect(@recipe).to be_valid
      end

      it 'コツが空でも保存できること' do
        @recipe.tip = nil
        expect(@recipe).to be_valid
      end
    end
    context 'レシピ投稿がうまくいかないとき' do
      it'タイトルが空だと保存できないこと' do
        @recipe.title = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("タイトルを入力してください")
      end

      it 'タイトルが41文字以上だと保存できないこと' do
        @recipe.title = 'a' * 41
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("タイトルは40文字以内で入力してください")
      end

      it 'レシピの分量が空だと保存できないこと' do
        @recipe.amount = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("レシピの分量を入力してください")
      end

      it 'レシピの分量が0だと保存できないこと' do
        @recipe.amount = 0
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("レシピの分量は0以外の値にしてください")
      end

      it '作り方が空だと保存できないこと' do
        @recipe.method = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("作り方を入力してください")
      end

      it '作り方が1001文字以上だと保存できないこと' do
        @recipe.method = 'a' * 1001
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("作り方は1000文字以内で入力してください")
      end

      it '公開設定が空だと保存できないこと' do
        @recipe.public_id = nil
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("公開設定を入力してください")
      end

      it 'コツは1001文字以上だと保存できないこと' do
        @recipe.tip = 'a' * 1001
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("コツは1000文字以内で入力してください")
      end

      it '材料名が入力されているのに分量が空だと保存できないこと' do
        @recipe.ingredients.build(name: 'test', quantity: nil)
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("材料の分量を入力してください")
      end

      it '材料の分量が0だと保存できないこと' do
        @recipe.ingredients.build(name: 'test', quantity: 0)
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("材料の分量は0以外の値にしてください")
      end

      it '材料の分量が入力されているのに材料名が空だと保存できないこと' do
        @recipe.ingredients.build(name: nil, quantity: 1)
        @recipe.valid?
        expect(@recipe.errors.full_messages).to include("材料名を入力してください")
      end
    end
  end
end
