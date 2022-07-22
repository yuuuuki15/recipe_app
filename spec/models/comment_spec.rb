require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント投稿' do
    context 'コメント投稿がうまくいくとき' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿がうまくいかないとき' do
      it 'contentが空だと保存できないこと' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメントを入力してください")
      end
    end
  end
end
