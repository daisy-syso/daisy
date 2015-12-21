class Informations::HealthInforsAPI < ApplicationAPI

  namespace :health_infors do
    get do
      information_types = Informations::InformationType.select("id, name, parent_id, top_number").where(parent_id: nil).order("created_at desc")
      information_type = params[:type].blank? ? information_types : Informations::InformationType.where(id: params[:type])
      information_type.each do |it|
        parent_id = it.parent_id || it.id
        pageset = (it.name == '头条' || it.name == '天天护理') ? 12 : 8
        top_infors = "(select *, 1 as rank from informations where information_type_id = #{parent_id} and is_top is true and types = 0 order by str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc limit #{it.top_number})"
        if it.parent_id.blank?
          ids = it.children_items.map(&:id) + [it.id]
          select_infos = "(select *, 2 as rank from informations where information_type_id in (#{ids.join(',')}) and is_top is not true and types = 0)"
        else
          part_infors = "(select *, 3 as rank from informations where information_type_id = #{it.id} and is_top is not true and types = 0)"
          ids = (it.parent_item.children_items.map(&:id) + [it.parent_item.id]).delete_if{|i| i == it.id}
          select_infos = part_infors + " union " + "(select *, 4 as rank from informations where information_type_id in (#{ids.join(',')}) and is_top is not true and types = 0)"
        end
        info_sql = "select * from ( " + top_infors + " union " + select_infos + " ) as infors order by rank asc, str_to_date(infors.created_at,'%Y-%m-%d %H:%i:%s') desc limit #{pageset} offset #{((params[:page] || 1).to_i - 1) * pageset}"
        it.latest_informations = Informations::Information.unscope(:where).find_by_sql(info_sql)
      end
      information_hotest_images = Informations::Information.select('id, name, image_url').unscope(:where).where(types: 7).order("created_at desc").limit(2)
      present :title, "健康资讯"
      present information_types: information_types
      present :information_hotest_images, information_hotest_images
      present :data, information_type, with: Informations::InformationTypeEntity
    end

    show! Informations::Information

    get ":id/read" do
      information =  Informations::Information.unscope(:where).find(params[:id])
      information.update_attributes(read_count: (information.read_count.to_i + 1))
      status 201
    end
  end

  namespace :precise_query do
    get do
      labels = [{
        title: "医院大全",
        # link: "#/list/hospitals/all?type=3",
        link: "#/list/hospitals/polyclinics?type=polyclinic&country=1",
        icon: "images/icons/1-1.png"
      }, {
        title: "疾病查询",
        link: "#/list/diseases/diseases",
        icon: "images/icons/1-2.png"
      }, {
        title: "找医生",
        link: "#/list/hospitals/doctors",
        icon: "images/icons/1-3.png"
      }, {
        title: "身边药房",
        link: "#/list/drugs/drugstores",
        icon: "images/icons/1-6.png"
      }, {
        title: "药品团购",
        link: "#/list/drugs/drugs",
        icon: "images/icons/1-5.png"
      }, {
        title: "医疗团购",
        link: "#/privileges/hospitals",
        icon: "images/icons/2-2.png"
      }, {
        # title: "医保查询",
        title: "最新优惠",
        # link: "#/list/eldercares/nursing_rooms",
        link: "#/privileges/newest",
        icon: "images/icons/2-4.png"
      }, {
        title: "体检团购",
        link: "#/list/examinations/examinations",
        icon: "images/icons/2-3.png"
      }, {
        title: "特色科室",
        link: "#/list/hospitals/characteristics",
        icon: "images/icons/2-1.png"
      }, {
        title: "症状查询",
        link: "#/list/symptoms/symptoms",
        icon: "images/icons/2-5.png"
      }, {
        title: "诊疗攻略",
        link: "#/list/price_search/strategy_list",
        # title: "手机挂号",
        # link: "#/list/hospitals/polyclinics",
        icon: "images/icons/1-4.png"
      }, {
        title: "养老精选",
        link: "#/list/eldercares/nursing_rooms",
        # title: "医保查询",
        # link: "#/list/social_securities/social_securities",
        icon: "images/icons/1-7.png"
      }, {
        title: "月子团购",
        # link: "#/list/maternals/maternal_halls",
        link: "#/privileges/maternals/confinement_centers",
        icon: "images/icons/2-6.png"
      }, {
        title: "海外医疗",
        link: "#/list/hospitals/overseas?country=2",
        icon: "images/icons/2-7.png"
      }, {
        title: "疾病保险",
        link: "#/privileges/insurances",
        icon: "images/icons/2-8.png"
      }, {
        title: "全部类别",
        link: "#/list/menus",
        icon: "images/icons/1-8.png"
      }]

      present btns
    end
  end

  namespace :hot do
    get do
      infors = Informations::Information.where(is_top: true).where.not(image_url: nil).order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(4)
      present :data, infors, with: Informations::InformationEntity
    end

    get 'guessed' do
      infos = Informations::Information.guessed.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)
      present :data, infos, with: Informations::InformationEntity
    end

    get 'recommended' do
      infos = Informations::Information.recommended.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)
      present :data, infos, with: Informations::InformationEntity
    end

    get 'selected' do
      infos = Informations::Information.selected.order("str_to_date(created_at,'%Y-%m-%d %H:%i:%s') desc").limit(12)
      present :data, infos, with: Informations::InformationEntity
    end
  end

end