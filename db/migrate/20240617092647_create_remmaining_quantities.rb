class CreateRemmainingQuantities < ActiveRecord::Migration[7.1]
  def change
    create_table :remmaining_quantities do |t|
      t.string :quantity

      t.timestamps
    end
  end
end
