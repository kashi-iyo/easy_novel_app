class PostMailer < ApplicationMailer
  default from: 'easynovel@example.com'

  def creation_email(post)
    @post = post
    mail(
      subject: '投稿完了メール',
      to: 'user@example.com',
      from: 'easynovel@example.com'
    )
  end
end
