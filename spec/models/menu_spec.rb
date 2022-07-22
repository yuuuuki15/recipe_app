require 'rails_helper'

RSpec.describe Menu, type: :model do
  before do
    @menu = FactoryBot.build(:menu)
  end

  describe '献立追加' do
    context '献立追加がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@menu).to be_valid
      end
    end

    context '献立追加がうまくいかないとき' do
      it 'dateが空だと保存できないこと' do
        @menu.date = ''
        @menu.valid?
        expect(@menu.errors.full_messages).to include("日付を入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @menu.user = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include("ユーザーを入力してください")
      end

      it 'recipeが紐付いていないと保存できないこと' do
        @menu.recipe = nil
        @menu.valid?
        expect(@menu.errors.full_messages).to include("レシピを入力してください")
      end
    end
  end
end
