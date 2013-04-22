class CreateQuestions < ActiveRecord::Migration
  def change
    create_table(:questions, :id => false) do |t|
      t.integer :id, :primary => true
      t.text :text
      t.boolean :dummy, :null => false
      t.references :quiz
    end
  end
end
