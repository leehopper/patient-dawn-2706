class CreateEntrants < ActiveRecord::Migration[5.2]
  def change
    create_table :entrants do |t|
      t.references :competition, foreign_key: true
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
