class Newfamilytree1 < ActiveRecord::Migration
  def change
    drop_table :people

    create_table :persons do |t|
      t.column :sex, :string
      t.column :name, :string

      t.timestamps
    end
  end
end
