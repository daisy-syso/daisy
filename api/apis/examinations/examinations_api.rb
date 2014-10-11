class Examinations::ExaminationsAPI < ApplicationAPI

  namespace :examinations do
    index! Examinations::Examination,
      title: "全国体检",
      filters: { 
        city: city_filters,
        examination_type: { class: Examinations::ExaminationType, title: "类别" },
        zone: fake_zone_filters,
        order_by: order_by_filters(Examinations::Examination)
      }
      
    show! Examinations::Examination
  end
end
