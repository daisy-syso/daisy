class UpdateCountryProvinceData < ActiveRecord::Migration
  def change
    country_china = Categories::Country.find_or_create_by(code: 'China', name: '中国')
    Categories::Province.update_all(country_id: country_china.id)

    country_other = Categories::Country.find_or_create_by(code: 'Other', name: '其它国家')
    %W(美国 韩国 日本).each do |country_name|
      Categories::Province.find_or_create_by(name: country_name) do |province|
        province.country_id = country_other.id
      end
    end
  end
end
