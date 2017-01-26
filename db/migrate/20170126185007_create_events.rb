class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.text :name
      t.datetime :when
      t.text :place
      t.text :purpose
      t.string :attachment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
