class CreateUrlResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :url_responses do |t|
      t.string :url, null: false
      t.jsonb :content, default: {}
      t.timestamps
    end
  end
end
