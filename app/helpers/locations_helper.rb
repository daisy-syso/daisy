module LocationsHelper
  def get_city_by_id(id)
    Categories::City.find(id).name
  end

  def get_county_by_id(id)
    Categories::County.find(id).name
  end

  def get_countries
    countries = Categories::Country.all

    get_instances(countries)
  end

  def get_proviences
    proviences = Categories::Provience.all

    get_instances(proviences)
  end

  def get_cities
    cities = Categories::City.all

    get_instances(cities)
  end

  def get_counties
    counties = Categories::County.all

    get_instances(counties)
  end

  def get_instances(instances)

    instances.map { |c| [c.name, c.id]}
  end
end
