class AddUserIdToPosts < ActiveRecord::Migration[5.2]

    def up
      execute 'DELETE FROM posts;'  #今まで作成した投稿を削除するSQL命令。
      add_reference :posts, :user, null: false, index: true
    end

    def down
      remove_reference :posts, :user, index: true
    end

end
