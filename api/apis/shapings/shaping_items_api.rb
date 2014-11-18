class Shapings::ShapingItemsAPI < ApplicationAPI

  namespace :shaping_items do
    index! Shapings::ShapingItem,
      title: "整形美容",
      filters: { 
        type: type_filters,
        city: fake_city_filters,
        county: fake_county_filters,
        order_by: order_by_filters(Shapings::ShapingItem),
        form: form_filters,
        # query: form_query_filters, 
        # alphabet: form_alphabet_filters
        need_order: form_switch_filters("无需预约"),
        has_return: form_switch_filters("返现"),
        template: form_radio_array_filters(%w(不限 团体寿险（消费型） 两全保险（红利返还） 万能险（满期返钱） 投资连结保险（保单贷款） 终身寿险（保费豁免） 定期寿险（可返钱） 分红险（年金转换）),
          "当前主题精选"),
        price_scope: form_price_scope_filters([1000, 5000, 10000, 50000, 100000])
      }

    show! Shapings::ShapingItem
  end

end
