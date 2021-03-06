class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :acronym
      t.references :city, foreign_key: true

      t.timestamps
    end
  end
end
