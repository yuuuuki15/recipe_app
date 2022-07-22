require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'お気に入り追加' do
    context 'お気に入り追加がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@favorite).to be_valid
      end
    end

    context 'お気に入り追加がうまくいかないとき' do
      it 'userが紐付いていないと保存できないこと' do
        @favorite.user = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("ユーザーを入力してください")
      end

      it 'recipeが紐付いていないと保存できないこと' do
        @favorite.recipe = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("レシピを入力してください")
      end
    end
  end
end
