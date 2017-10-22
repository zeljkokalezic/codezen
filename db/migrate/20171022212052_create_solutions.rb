class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.references :problem, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status
      t.text :code
      t.integer :score

      t.timestamps
    end
  end
end
