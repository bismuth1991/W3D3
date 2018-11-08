class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, null: false
      t.string :short_url
      t.integer :user_id
      t.timestamps
    end

    add_index :shortened_urls, [:long_url, :short_url], unique: true
  end
end
