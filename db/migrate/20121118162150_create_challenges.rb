class CreateChallenges < ActiveRecord::Migration
  def change
    create_table(:challenges, :id => false) do |t|
      t.string :uuid, :primary => true
      t.text :answers
      t.string :classification_label
      t.boolean :training_record, default: false
      t.references :app
      t.timestamps
    end
  end
end
