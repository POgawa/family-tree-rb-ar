class Newfamilytree < ActiveRecord::Migration
  def change
    create_table :married do |t|
      t.column :spouse1_id, :int
      t.column :spouse2_id, :int
      t.column :divorced, :boolean

      t.timestamps
    end
    create_table :parents do |t|
      t.column :father_id, :int
      t.column :mother_id, :int
      t.column :person_id, :int

      t.timestamps
    end
  end
end
