class AddUniqueIndexForDealers < ActiveRecord::Migration[6.1]
  def up
    execute(
      <<-SQL
      CREATE UNIQUE INDEX index_dealers_on_name_lat_long
      ON dealers (REPLACE(LOWER(name), ' ', ''), latitude, longitude);
      SQL
    )
  end

  def down
    execute(
      <<-SQL
        DROP INDEX index_dealers_on_name_lat_long;
      SQL
    )
  end
end
