class CreateUserReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :user_reviews do |t|
      t.integer :rating
      t.text :content
      t.references :swap, null: false, foreign_key: true
      t.references :reviewer, null: false, foreign_key: { to_table: 'users' }
      t.references :reviewed, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
