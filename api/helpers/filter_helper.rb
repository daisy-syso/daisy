module FilterHelper
  extend ActiveSupport::Concern

  def parse_option_value *args
    value = args.pop
    if value.kind_of? Proc
      instance_exec *args, &value
    elsif value
      value
    elsif block_given?
      yield *args
    end
  end

  def generate_filter key, options
    parse_option_value options[:before]

    filter = options[:meta] ? options[:meta].dup : {}
    filter[:key] ||= parse_option_value options[:key] { key }
    filter[:title] ||= parse_option_value options[:title]
    filter[:template] ||= parse_option_value options[:template] { :list }
    filter[:children] ||= parse_option_value key, options[:children] do
      options[:class].filters
    end if options[:class] || options[:children]
    filter[:current] = parse_option_value key, options[:current] do
      params[key] || options[:default]
    end
    filter
  end

  def append_url_to_filters array, url
    array.each do |hash|
      hash[:url] = url if hash[:params]
      append_url_to_filters hash[:children], url if hash[:children]
    end
  end

  module ClassMethods

    def city_filters
      { 
        meta: { 
          keep: :city,
          link: :"categories/cities"
        },
        default: 1,
        title: "位置",
        titleize: true,
      }
    end

    def fake_city_filters
      { 
        meta: { 
          keep: :city,
          link: :"categories/cities"
        },
        default: 1, 
        class: Categories::City, 
        title: "位置", 
        titleize: true, 
        filter_only: true
      }
    end

    def county_filters
      { 
        title: "商圈",
        children: proc { Categories::County.filters(params[:city]) },
      }
    end

    def fake_county_filters
      { 
        title: "商圈",
        children: proc { Categories::County.filters(params[:city]) },
        filter_only: true
      }
    end

    def examination_parent_type
      { 
        title: proc { Examinations::ExaminationType.where(id: params[:type]).first.try(:name) || "类别" } ,
        key: "type",
        children: proc { 
          Examinations::ExaminationType.where(parent_id: nil).map do |type|
            {id: type.id,
             title: type.name,
             url: "#/list/examinations/examination_type?type=#{type.id}"
           }

          end
         },
         current: proc { params[:examination_type]}
        # filter_only: true
      }
    end
 
    def hospital_charge_type
      {
        title: proc {Hospitals::HospitalType.where(id: params[:hospital_type]).first.try(:name) || "类别" } ,
        key: "type",
        children: proc {
          Hospitals::HospitalType.where(parent_id: params[:hospital_parent_type]).map do |type|
            {
              id: type.id,
              title: type.name,
              url: "#/list/hospitals/hospital_charges?hospital_parent_type=#{type.parent_id}&hospital_type=#{type.id}"
            }
          end
        },
        current: proc{ params[:hospital_parent_type] },
        # hospital_parent_type: "proc { params[:hospital_parent_type] }
        # "
      }
    end

    def price_filters
      { 
        type: Hash,
        using: [:to, :from],
        scope_only: true
      }
    end

    def form_price_filters
      { 
        meta: { 
          key: :price,
          title: "价格区间", 
          template: :price,
        },
        type: Hash,
        using: [:to, :from],
        append: :form 
      }
    end

    def form_price_scope_filters array
      { 
        meta: { 
          key: :price_scope,
          title: "价格区间", 
          template: :radio,
        },
        type: String,
        children: proc do
          children = []
          children.push title: "不限", id: "-"
          children.push title: "#{array.first-1}元 以下", id: "0-#{array.first}"
          array.each_cons(2) do |from, to|
            children.push title: "#{from}元 至 #{to}元", id: "#{from}-#{to}"
          end
          children.push title: "#{array.last}元 以上", id: "#{array.last}-"
          children
        end,
        append: :form 
      }
    end

    def form_filters
      {
        meta: { 
          template: :form,
        },
        title: "筛选",
        filter_only: true
      }
    end

    def form_radio_filters klass, title
      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        children: proc { klass.form_filters },
        append: :form 
      }
    end

    def form_radio_array_filters array, title
      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        type: String,
        children: proc do 
          array.each_with_index.map do |title, index| 
            { title: title, id: index }
          end
        end,
        append: :form 
      }
    end

    def form_radio_array_filters_new title

      # hospital_type = proc {params[:hospital_type]}
      h = { "16" => %w(不限 B超引导下前列腺活检术 前列腺针吸细胞学活检术
                  前列腺按摩 前列腺注射 前列腺特殊治疗(微波法) 前列腺特殊治疗(射频法)
                  前列腺特殊治疗(激光法)),
        "22" => %w(不限 阴茎延长 阴茎增粗),
        "23" => %w(不限 包皮环切术 激光手术),
        "20" => %w(不限 精索静脉转流术 精索静脉转流术 精索静脉曲张栓塞术 精索静脉曲张高位结扎术 精索静脉曲张分流术),
        "19" => %w(不限 阴囊、双侧睾丸、附睾B超检查 阴囊、双侧睾丸、附睾彩色多普勒超声检查 睾丸阴茎海绵体活检术(包括穿刺、切开)
                  睾丸鞘膜翻转术 睾丸附件扭转探查术(含睾丸扭转复位术) 睾丸破裂修补术 睾丸固定术(含疝囊高位结扎术) 睾丸切除术 
                    睾丸肿瘤腹膜后淋巴结清扫术 自体睾丸移植术 附睾睾丸活检术 ),
        "18" => %w(不限 阴茎海绵体造影 夜间阴茎胀大试验(含硬度计法) 阴茎超声血流图检查
                    阴茎勃起神经检查(含肌电图检查) 睾丸阴茎海绵体活检术(包括穿刺、切开) 
                    阴茎海绵体内药物注射 阴茎赘生物电灼术(包括冷冻术) 阴茎动脉测压术 
                    阴茎海绵体灌流治疗术 尿道下裂阴茎下弯矫治术 阴茎包皮过短整形术  
                    阴茎外伤清创术 阴茎再植术 阴茎囊肿切除术 阴茎硬节切除术 阴茎部分切除术(包括阴茎癌切除术) 
                    阴茎全切术(阴茎癌切除术) 阴茎重建成形术(含假体置放术) 阴茎再造术(含龟头再造和假体置放) 
                    阴茎畸型整形术(包括阴茎弯曲矫正) 阴茎延长术(包括阴茎加粗、隐匿型延长术) 
                    阴茎阴囊移位整形术(增加会阴型尿道下裂修补时加收50%) 尿道阴茎海绵体分流术 阴茎血管重建术 
                    阴茎海绵体分离术 阴茎静脉结扎术(包括海绵体静脉、背深静脉)),
        "21"  =>  %w(不限 高位隐睾下降固定术（含疝修补术） 经腹腔镜隐睾探查术（含隐睾切除术）)
        
      }

      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        type: String,
        children: proc do 
          id = params[:hospital_type]
          array = h[id.to_s] || %w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术)
          array.each_with_index.map do |title, index| 
            { title: title, id: index }
          end
        end,
        append: :form 
      }

    end

    def form_query_filters title = "搜索"
      {
        meta: { 
          title: title, 
          template: :string,
        },
        type: String,
        append: :form,
      }
    end

    def alphabet_filters
      {
        title: "字母",
        children: ('A'..'Z').map do |s| 
          { title: s, id: s }
        end
      }
    end

    def form_alphabet_filters
      {
        meta: { 
          key: :alphabet,
          title: "字母搜索", 
          template: :alphabet,
        },
        type: String,
        append: :form
      }
    end

    def form_switch_filters title
      {
        meta: { 
          title: title,
          template: :switch,
        },
        type: Object,
        current: proc { |key| params[key] == "true" },
        append: :form
      }
    end

    def type_filters current = nil
      {
        meta: {
          link: :types
        },
        type: String,
        title: "全部类别",
        filter_only: true,
        current: proc { params[:type] || current }
      }
    end

    def search_by_filters options
      {
        type: Symbol,
        filter_only: true,
        default: options[:default],
        key: proc { params[:search_by] },
        before: proc do
          search_by_key = params[:search_by]
          search_by_options = options[search_by_key]
          has_scope search_by_key unless search_by_options[:filter_only]
        end,
        title: proc do
          search_by_options = options[params[:search_by]]
          search_by_options[:title]
        end,
        children: proc do
          search_by_options = options[params[:search_by]]
          parse_option_value search_by_options[:children] do
            search_by_options[:class].filters
          end
        end,
        current: proc do
          params[params[:search_by]]
        end
      }
    end

    def order_by_filters klass, options = {}
      {
        default: options[:default] || :auto,
        type: String,
        title: "智能排序",
        children: proc do
          filters = []
          filters << { title: "智能排序" , id: :auto }
          if klass < Localizable && params[:location]
            filters << { title: "离我最近" , id: :nearest }
          end
          if klass < Reviewable
            filters << { title: "评价最好" , id: :favoriest }
            filters << { title: "人气最高" , id: :hotest }
          end
          filters << { title: "最新发布" , id: :newest }
          if klass.attribute_names.include? "sale_price"
            filters << { title: "价格最低" , id: :cheapest }
            filters << { title: "价格最高" , id: :most_expensive }
          end
          parse_option_value filters, options[:children]
          filters
        end,
        has_scope: proc do |endpoint, collection, key|
          case key.to_sym
          when :auto
            collection
          when :nearest
            params = endpoint.params
            lat = params[:location][:lat]
            lng = params[:location][:lng]
            collection.nearest(lat, lng)
          when :favoriest
            collection.order(star: :desc)
          when :hotest
            collection.order(reviews_count: :desc)
          when :newest
            collection.order(created_at: :desc)
          when :cheapest
            collection.order(ori_price: :asc)
          when :most_expensive
            collection.order(ori_price: :desc)
          else
            if options[:has_scope]
              instance_exec endpoint, collection, key, &options[:has_scope]
            else
              collection
            end
          end
        end
      }
    end

    def hospital_order_by_filters
      order_by_filters Hospitals::Hospital, {
        default: :hospital_level,
        children: proc do |filters|
          filters.insert(1, { title: "医院等级" , id: :hospital_level })
        end,
        has_scope: proc do |endpoint, collection, key|
          if key.to_sym == :hospital_level
            collection.hospital_level
          else
            collection
          end
        end
      }
    end

  end
end
