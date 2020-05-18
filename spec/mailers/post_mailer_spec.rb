require "rails_helper"

describe PostMailer, type: :mailer do

  let(:post) { FactoryBot.create(:post, title: 'メイラーSpecを書く', description: '送信したメールの内容を確認する', content: '本文') }

  let(:text_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/plain; charset=UTF-8' }
    part.body.raw_source
  end
  let(:html_body) do
    part = mail.body.parts.detect { |part| part.content_type == 'text/html; charset=UTF-8' }
    part.body.raw_source
  end

  describe '#creation_email' do
    let(:mail) { PostMailer.creation_email(post) }

    it '想定通りのメールが生成されている'do
      #ヘッダ
      expect(mail.subject).to eq('投稿完了メール')
      expect(mail.to).to eq(['user@example.com'])
      expect(mail.from).to eq(['easynovel@example.com'])

      #text形式の本文
      expect(text_body).to match('以下の投稿を作成しました')
      expect(text_body).to match('メイラーSpecを書く')
      expect(text_body).to match('送信したメールの内容を確認する')
      expect(text_body).to match('本文')

      #html形式の本文
      expect(text_body).to match('以下の投稿を作成しました')
      expect(text_body).to match('メイラーSpecを書く')
      expect(text_body).to match('送信したメールの内容を確認する')
      expect(text_body).to match('本文')
    end
  end

end
