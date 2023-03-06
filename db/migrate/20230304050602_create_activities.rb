class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.datetime :sleep_at
      t.datetime :wake_up_at

      t.timestamps
    end
  end
end
