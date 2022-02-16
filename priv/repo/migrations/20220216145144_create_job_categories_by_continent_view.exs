defmodule Welcome.Repo.Migrations.CreateJobCategoriesByContinentView do
  use Ecto.Migration

  def up do
    execute """
    CREATE VIEW job_categories_by_continent AS

      SELECT p.category_name, l.continent, count(*)
      FROM job_offers j
      LEFT JOIN professions p ON j.profession_id = p.id
      LEFT JOIN locations l ON j.location_id = l.id

      GROUP BY l.continent, p.category_name
      ORDER BY l.continent, p.category_name;
    """
  end

  def down do
    execute """
    DROP VIEW job_categories_by_continent;
    """
  end
end
