class Examinations::ExaminationsAPI < Grape::API
  extend ResourcesHelper

  namespace :examinations do
    index! Examinations::Examination,
      title: "全国体检",
      filters: { 
        city: { default: 1, class: Categories::City, title: "位置" },
        examination_type: { class: Examinations::ExaminationType, title: "体检类型" }
      }
  end
end
