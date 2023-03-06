class CreateClockOperations < ActiveRecord::Migration[7.0]
  def change
    create_table :clock_operations do |t|
      t.time :clock_at

      t.timestamps
    end
  end
end
