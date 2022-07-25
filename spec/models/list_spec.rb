require 'rails_helper'

RSpec.describe List, type: :model do
  before do
    @list = FactoryBot.build(:list)
  end

  describe '買い物リスト追加' do
    context '買い物リスト追加がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@list).to be_valid
      end

      it 'ingredient_quantityは空でも保存できること' do
        @list.ingredient_quantity = ''
        expect(@list).to be_valid
      end
    end

    context '買い物リスト追加がうまくいかないとき' do
      it 'ingredient_nameが空だと保存できないこと' do
        @list.ingredient_name = ''
        @list.valid?
        expect(@list.errors.full_messages).to include("食材名を入力してください")
      end

      it 'userが紐付いていないと保存できないこと' do
        @list.user = nil
        @list.valid?
        expect(@list.errors.full_messages).to include("ユーザーを入力してください")
      end
    end
  end
end
