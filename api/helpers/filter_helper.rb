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
    filter[:title] ||= parse_option_value key, options[:title] 
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
        title: proc {Categories::County.find_by_id(params[:county]).try(:name) || "全城" },
        children: proc { Categories::County.filters(params[:city]) },
      }
    end

    def fake_county_filters
      { 
        title: proc {Categories::County.find_by_id(params[:county]).try(:name)  || "全城" },
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

    def form_radio_array_filters_new type, title
      # hospital_type = proc {params[:hospital_type]}
#       h1 = { 
#         "0" => %w(不限 (含淋巴结清扫和取活检) 耻骨上前列腺切除术 耻骨后前列腺切除术 经会阴前列腺切除术 前列腺囊肿切除术 前列腺脓肿切开术 经尿道前列腺电切术(激光法) 经尿道前列腺电切术(电切法) 经尿道前列腺电切术(汽化法) 经尿道前列腺气囊扩张术 经尿道前列腺支架置入术 前列腺摘除术),
#         "16" => %w(不限 B超引导下前列腺活检术 前列腺针吸细胞学活检术
#                   前列腺按摩 前列腺注射 前列腺特殊治疗(微波法) 前列腺特殊治疗(射频法)
#                   前列腺特殊治疗(激光法)),
#         "22" => %w(不限 阴茎延长 阴茎增粗),
#         "23" => %w(不限 包皮环切术 激光手术),
#         "20" => %w(不限 精索静脉转流术 精索静脉转流术 精索静脉曲张栓塞术 精索静脉曲张高位结扎术 精索静脉曲张分流术),
#         "19" => %w(不限 阴囊、双侧睾丸、附睾B超检查 阴囊、双侧睾丸、附睾彩色多普勒超声检查 睾丸阴茎海绵体活检术(包括穿刺、切开)
#                   睾丸鞘膜翻转术 睾丸附件扭转探查术(含睾丸扭转复位术) 睾丸破裂修补术 睾丸固定术(含疝囊高位结扎术) 睾丸切除术 
#                     睾丸肿瘤腹膜后淋巴结清扫术 自体睾丸移植术 附睾睾丸活检术 ),
#         "18" => %w(不限 阴茎海绵体造影 夜间阴茎胀大试验(含硬度计法) 阴茎超声血流图检查
#                     阴茎勃起神经检查(含肌电图检查) 睾丸阴茎海绵体活检术(包括穿刺、切开) 
#                     阴茎海绵体内药物注射 阴茎赘生物电灼术(包括冷冻术) 阴茎动脉测压术 
#                     阴茎海绵体灌流治疗术 尿道下裂阴茎下弯矫治术 阴茎包皮过短整形术  
#                     阴茎外伤清创术 阴茎再植术 阴茎囊肿切除术 阴茎硬节切除术 阴茎部分切除术(包括阴茎癌切除术) 
#                     阴茎全切术(阴茎癌切除术) 阴茎重建成形术(含假体置放术) 阴茎再造术(含龟头再造和假体置放) 
#                     阴茎畸型整形术(包括阴茎弯曲矫正) 阴茎延长术(包括阴茎加粗、隐匿型延长术) 
#                     阴茎阴囊移位整形术(增加会阴型尿道下裂修补时加收50%) 尿道阴茎海绵体分流术 阴茎血管重建术 
#                     阴茎海绵体分离术 阴茎静脉结扎术(包括海绵体静脉、背深静脉)),
#         "21"  =>  %w(不限 高位隐睾下降固定术（含疝修补术） 经腹腔镜隐睾探查术（含隐睾切除术）)
        
#       }

#       h2 = {
#         "0" => %w(不限 双眼皮（埋线法） 双眼皮（切开法） 内眼角 外眼角 上眼皮下垂 上下眼睑 眼睫毛皮肤切除 眼睫毛植毛 祛眼袋 内眦成形术 ),
#         "1" => %w(不限 凹陷性疤痕 面颈疤痕修复 体表疤痕修复 体表肿物切除 植皮修复术),
#         "59" => %w(不限 隆鼻术 鼻再造 体表疤痕修复 体表肿物切除 植皮修复术 鼻翼缩小 鼻头缩小 鼻翼再造 鼻小柱再造 朝天鼻矫正 鼻尖整形), 
#         "3" => %w(不限 全耳再造修复 外耳再造修复 小耳畸形 招风耳矫正),
#         "4" => %w(不限 肉毒素除皱术 小切口除皱 额部除皱 面部悬吊术 隆頦术 顳部填充术 颧骨矫形 下颌角矫形 颚裂修复术 酒窝成形 注射瘦脸 丰太阳穴 注射丰下巴 丰额头),
# # 激光美容
#         "5" => %w(不限 光子嫩肤 激光美容 激光除皱 面部嫩肤 电波拉皮),
# # 激光脱毛
#         "6" => %w(不限 脱腋毛 女性唇毛 男性胡须 大腿 小腿 前臂 胸毛、腹毛 额、颊、颌（单侧） ),
# # 口唇整形
#         "61" => %w(不限 丰唇术 厚唇变薄 酒窝成形 唇红缺损畸形 唇裂畸形修复 口角歪斜矫正 小口改大 大口改小),
# # 毛发移植
#         "8" => %w(不限 植发 植眉 睫毛种植 胡须种植 ),
# # 其他整形
#         "70" => %w(不限 注射瘦小腿 深蓝热塑射频 塑美极 注射丰臀 提臀 腋臭治疗 微创汗腺清除 手功能重建修复 多指整形术 并指整形术 手指再造),
# # 祛斑除痣
#         "10" => %w(不限 祛斑 一般祛痣 祛太田痣 祛纹身),
# # 生殖整形
#         "11" => %w(不限 包皮环切 阴茎延长 阴茎增大 处女膜修复 阴道紧缩术 小阴唇肥大矫正 阴道再造 阴茎再造 ),
# # 吸脂减肥
#         "12" => %w(不限 脂肪抽吸术 下颌吸脂 双面颊吸脂 取脂肪垫 腰部吸脂 腹部吸脂 手臂吸脂 大腿吸脂 小腿吸脂 臀部吸脂 背部吸脂 ),
# # 胸部整形
#         "62" => %w(不限 假体丰胸 自体脂肪丰胸 乳房再造（一期） 巨乳缩小术 乳房下垂悬吊术 乳头内陷 不良丰胸矫正 隆胸注射物取出 微创附乳祛除术 乳晕缩小 乳晕漂红),
# # 注射美容
#         "14" => %w(不限 一针瘦脸 BOTOX除皱)
#       }

#       h3 = {
#         "0" => %w(不限 全瓷牙 镍铬烤瓷牙 钴铬合金烤瓷牙 钯银合金烤瓷牙 钯金合金烤瓷牙 钛合金烤瓷牙 E.MAX全瓷牙 美国"雷诺皓瓷牙"瑞典Procera皓瓷牙 德国泽康皓瓷牙),
#         # 49拔除术
#         "49" => %w(不限 乳牙拔除术 前门牙拔除术 双尖牙拔除术 后磨牙拔除术 智齿/残冠拔除 阻生/复杂牙拔除 根尖切除术),
#         # 32拔牙
#         "32" => %w(不限 乳牙拔除 前牙拔除 后牙拔除),
#         # 保持器
#         "0" => %w(不限 正畸保持器 间隙保持器),
#         # 36补牙
#         "36" => %w(不限 银汞合金补牙 SHOUFU激光补牙 Ivocar光固化补牙 DENSPLY激光补牙 Denfil 光固化补牙 Coltene光固化补牙 3M 光固化补牙 NP钢桩核 钛合金桩核 纯钛桩核（99%） 黄金桩核（86.5%） 全瓷桩核（瑞士康特） 泽康全瓷桩核（德国）),
#         # 35根管治疗
#         "35" => %w(不限 根管治疗价格（前牙） 根管治疗价格（后牙） 根管再治疗价格（前牙） 根管再治疗价格（后牙）),
#         # 33活动义齿
#         "33" => %w(不限 进口胶牙 日本塑钢树脂牙 美国生物合金托 纯钛托),
#         # 43矫正器
#         "43" => %w(不限 活动矫正器 Frankel功能矫正器 edgewise方丝弓 Andrews直丝弓 Begg矫正器 口外支抗矫治器 天使隐形矫正 舌侧隐形矫正),
#         # 精密附件 
#         "0" => %w(不限 栓道式精密附件 按扣式精密附件 插销式精密附件 磁吸式精密附件 键槽缓压式精密附件 套筒式精密附件),
#         # 烤瓷牙
#         "0" => %w(不限 全瓷牙价格 镍铬烤瓷牙 钴铬合金烤瓷牙 钯银合金烤瓷牙 钯金合金烤瓷牙 钛合金烤瓷牙 E.MAX全瓷牙 美国"雷诺皓瓷牙” 瑞典Procera皓瓷牙 德国泽康皓瓷牙),
#         # 48麻醉
#         "48" => %w(不限 碧蓝麻醉注射 无痛麻醉机),
#         # 44排牙
#         "44" => %w(不限 碧蓝麻醉注射 无痛麻醉机),
#         # 46其他牙科
#         "46" => %w(不限 口腔溃疡治疗 粘膜封闭治疗 口腔取模设计 手术矫正 口腔异物取出 牙周病系统治疗 牙饰粘结 活动义齿修理 内脱色法 粘液囊肿摘除术 骨隆突修整术 牙槽突修整术 系带矫正术 牙齿导萌术 脓肿口内切开引流术 牙槽骨骨折固定术 清创缝合术 颞下颌关节复位术 颞下颌关节封闭术 鼾症矫正器 三叉神经痛封闭 根面平整术 松牙固定术 牙龈成形术 翻瓣术 盲袋切除术 根分叉搔刮手术 牙冠延长术 截根术 分根术 牙半切除术 龈颊沟加深术 上颌窦底提升术 植骨术 种植牙手术 牙移植术 倍骼生植骨术 调合术 拆线),
#         # 42嵌体
#         "42" => %w(不限 水门丁粘结 POLY-F粘结 FUJI1粘结 3M玻璃离子粘结 3M激光树脂粘结 镍铬合金嵌体 钛合金嵌体 钴铬合金嵌体 纯钛嵌体（99%） 黄金嵌体（56%） 黄金嵌体75% 黄金嵌体86.5% 纯钛冠（99%以上） 钴铬合金冠 白金嵌体（97%） IVOCAR全瓷嵌体 PROCLAR全瓷嵌体 泽康全瓷嵌体),
#         # 34全口义齿
#         "34" => %w(不限 胶托全口义齿 钢托全口义齿 纯钛托全口义齿 全口软衬垫底), 
#         # 47上药
#         "47" => %w(不限 牙周冲洗上药 PIERO牙周上药),
#          # 29牙齿矫正
#         "29" => %w(不限 儿童牙齿矫正 成人牙齿矫正 舌侧牙齿矫正),
#          # 牙齿美白
#         "0" => %w(不限 冷光牙齿美白 药物牙齿美白),
#         # 39牙齿漂白
#         "39" => %w(不限 美国Beyound 美Oplense漂白),
#         # 45牙冠
#         "45" => %w(不限 NP金属钢冠 黄金冠（86.5%） 钛合金冠),
#         # 37牙基托
#         "37" => %w(不限 胶托（小/大） 隐形托（小/大） 钢托（小/大） 钛托（99%）（小/大） 黄金托（小/大）),
#         # 41牙修复材料
#         "41" => %w(不限 临时树脂牙 拆除修复牙冠 拆除金属材料),
#         # 隐形矫正
#         "0" => %w(不限 种植牙(Dentium系统) 种植牙(德国Bego系统) 种植牙(Osstem,SS系统) 种植牙(Ankylos系统) 种植牙(ITI系统) 种植牙(NOBEL系统)),
#         # 40种植体
#         "40" => %w(不限 国产种植体 韩国种植体 ITI种植体 Brandmark种植体), 
#         # 50X光
#         "50" => %w(不限 X光牙片 全景X光片 咬合X片 头颅侧位片)
#       }

#       h4 = {
#         # 分泌物检验
#         "0" => %w(不限 剖腹产 卵巢囊切除术 子宫全切 子宫次全切 取环 放环 清宫 无痛清宫 引产术 子宫肌瘤剜除), 
#         "83" => %w(不限 阴道分泌物检查 细菌性阴道病监测（BV）),
#         # 尿液检验
#         "84" => %w(不限 尿妊娠试验 尿HL检测 尿十一项+尿沉渣 尿微量白蛋白),
#         # 通用检查
#         "85" => %w(不限 单纯疱疹病毒抗体测定四项 淋球菌培养 衣原体抗原 支原体培养及药敏 宫颈刮片细胞学检查 标本病例检查 弓形体抗原测定 梅毒快速血浆反应实验（TRUST） 梅毒螺旋体异性抗体（TPPA） TCT脱落细胞检查),
#         # 阴道检查
#         "87" => %w(不限 电子数码阴道镜检查 妇科常规检查),
#         # B超
#         "82" => %w(不限 阴道彩超 阴道黑白超 腹部彩色超声检查 子宫附件B超 孕检彩色超声检查),
#         # 血液
#         "86" => %w(不限 全血细胞分析 ABO血型定型 Rb(D)定型 凝血四项（PT,TT,APTT,FIB） 乙肝表面抗原 术前四项（乙肝两对半、RPR、抗HCV、抗HIV） 不孕五项（化学发光法）优生五项（化学发光法） 性激素六项 血清泌乳素测定 血清促黄体生成素测定 血清促卵泡刺激素测定 血清绒毛促性激素定量（血-HCG） 甲功三项 甲功五项 风湿四项 孕酮测定 免疫球蛋白四项 唐氏综合症Ⅱ期3联 凝血二项)
#       }

#       h5 = {
#         "0" => %w(不限 颈椎病推拿治疗 寰枢关节失稳推拿治疗 颈椎小关节紊乱推拿治疗 胸椎小关节紊乱推拿治疗 腰椎小关节紊乱推拿治疗 腰椎间盘突出推拿治疗 第三腰椎横突综合征推拿治疗 骶髂关节紊乱症推拿治疗 强直性脊柱炎推拿治疗 外伤性截瘫推拿治疗 退行性脊柱炎推拿治疗 ),
#         # 灸法
#         "72" => %w(不限 灸法(艾柱灸) 灸法(艾条灸) 灸法(艾箱灸) 灸法(天灸) 灸法(其他灸) 隔物灸法(隔姜灸) 隔物灸法(药饼灸) 隔物灸法(隔盐灸) 隔物灸法(其它灸) 灯火灸 药线点灸 拔罐疗法(火罐)（3罐/次） 拔罐疗法(电火罐)（3罐/次） 拔罐疗法(闪罐)（3罐/次） 拔罐疗法(着罐)（3罐/次） 拔罐疗法(电罐)（3罐/次） 拔罐疗法(磁疗罐)（3罐/次） 拔罐疗法(真空拔罐)（3罐/次） 拔罐疗法(其它罐)（3罐/次） 药物罐 水罐 督灸 大灸 雷火灸 太乙神针灸),
#         # 推拿疗法
#         "00" => %w(不限 落枕推拿治疗 颈椎病推拿治疗 颈椎病正骨复位 肩周疾病推拿治疗 网球肘推拿治疗 急性腰扭伤推拿治疗 腰部疾病推拿治疗 腰椎间盘突出正骨复位 膝关节骨性关节炎推拿治疗 内科慢性腹泻推拿治疗 II型糖尿病推拿治疗 内科便秘推拿治疗 慢性胃病推拿治疗 内科失眠推拿治疗 胃下垂推拿治疗 月经不调推拿治疗 痛经推拿治疗 其他推拿治疗 小儿捏脊治疗 药棒穴位按摩治疗（3穴位） 脊柱小关节紊乱推拿治疗 小儿斜颈推拿治疗 环枢关节半脱位推拿治疗) ,
#         # 针刺
#         "73" => %w(不限 普通针刺（体针）（5穴位/次） 普通针刺(快速针)（5穴位/次） 普通针刺(磁针)（5穴位/次） 普通针刺(金针)（5穴位/次） 普通针刺(姜针)（5穴位/次） 普通针刺(药针)（5穴位/次） 其它普通针刺（5穴位/次） 温针（5穴位/次） 手指点穴（5穴位/次） 馋针 微针针刺 锋钩针 头皮针 眼针（单眼） 梅花针 七星针 火针(3穴位) 电火针(3穴位) 埋针治疗 耳针(单耳) 芒针 电针(普通电针)（2穴位）浮针 微波针（2穴位） 激光针（2穴位） 磁热疗法（2穴位） 放血疗法 穴位注射 穴位封闭 自血疗法 穴位贴敷治疗 内脏平滑肌痉挛性疼痛止痛敷贴 杵针 圆针),
#         # 中医肛肠
#         "74" => %w(不限 直肠脱出复位治疗 三度直肠脱垂复位治疗 直肠周围硬化剂注射治疗 内痔硬化剂注射治疗(枯痔治疗) 高位复杂肛瘘挂线治疗 血栓性外痔切除术 环状混合痔切除术 环状混合痔脱出嵌顿切除术 混合痔外剥内扎术 肛外括约肌折叠术 直肠前突修补术 肛瘘封堵术 肛周药物注射封闭术 肛周坏死性筋膜炎清创术 肛门直肠周围脓腔搔刮术 直肠前突出注射术 直肠脱垂注射术) ,
#         # 中医骨伤
#         "75" => %w(不限 骨折橇拨复位术 骨折经皮钳夹复位术 骨折闭合复位经皮穿刺（钉）内固定术 骨折闭合复位经皮穿刺（钉）内固定术四肢长骨干、近关节加收 关节脱位手法整复术 陈旧性脱位关节脱位手法整复术 髋关节脱位手法整复术 下颌关节脱位手法整复术 指(趾)间关节脱位手法整复术 骨折外固定架固定术 骨折外固定架固定术复查调整 骨折夹板外固定 骨折夹板外固定复查调整 关节错缝术 麻醉下腰椎间盘突出症大手法治疗 关节粘连传统松解术 中医定向透药疗法 腱鞘囊肿挤压术 腱鞘囊肿挤压术 腰间盘三维牵引复位术),
#         # 中医特殊疗法
#         "76" => %w(不限 白内障针拨术（单眼） 白内障针拨术（双眼） 白内障针拨吸出术（单眼） 白内障针拨吸出术（双眼） 白内障针拨吸出术（双眼） 白内障针拨套出术（双眼） 眼结膜囊穴位注射（单眼） 眼结膜囊穴位注射（双眼） 小针刀治疗 钩针疗法 刃针治疗 红皮病清消术 扁桃体烙法治疗 鼻中隔烙法治疗 药线引流治疗 耳咽中药吹粉治疗 中药硬膏热贴敷治疗 中药直肠滴入治疗 刮痧治疗 烫熨治疗 体表瘘管切开搔爬术 足底反射治疗),
#         # 中医外治
#         "77" => %w(不限 中药化腐清创术 中药涂擦治疗（>10%体表面积） 中药热奄包治疗 中药封包治疗 中药熏洗治疗 中药熏洗治疗（半身） 中药熏洗治疗（全身） 中药蒸汽浴治疗(30分钟) 中药蒸汽浴治疗（>30分钟） 中药塌渍治疗（10%体表面积） 中药塌渍治疗（>10%体表面积） 中药熏药治疗 赘生物中药腐蚀治疗（每赘生物） 挑治 割治)
#       }
      # case type
      # when "andrology"
      #   h = h1
      # when "plastic"
      #   h = h2
      # when "dental"
      #   h = h3
      # when "gynaecology"
      #   h = h4
      # when "tcm"
      #   h = h5
      # end
      h = FilterOfHospital[type]
      { 
        meta: { 
          title: title, 
          template: :radio,
        },
        type: String,
        children: proc do 
          id = params[:hospital_type]
          array = h[id] || h[0]
          p array
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

    def type_filters title="全部类别", current=nil 
      {
        meta: {
          link: :types
        },
        type: String,
        title: title,
        filter_only: true,
        current: proc { params[:type] || current}
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
          parse_option_value search_by_options[:title] 
          # search_by_options[:title]
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

    def common_diseas_filters
      {
        title: proc do
          Diseases::CommonDisease.all.where(id: params[:common_disease]).first.try(:name) || "鼻部病" 
        end,
        key: "common_disease",
        template: "list",
        children: proc do
          Diseases::CommonDisease.all.map do |common_disease|
            {title: common_disease.name, id: common_disease.id}
          end
        end,
        current: proc {params[:common_disease]},
        class: :common_disease
      }
    end

    def hospital_type_filters
      {
        title: proc do
           Hospitals::HospitalType.find_by_id(params[:hospital_type]).try(:name) || "全部"
        end,
        key: "hospital_type",
        template: "list",
        children: proc do
          Hospitals::HospitalType.where(parent_id: nil).map do |hospital_type|
            {
              image_url:hospital_type.image_url, 
              title: hospital_type.name, 
              children: hospital_type.hospital_types.map do |ht|
                {
                  title: ht.name
                }
              end, 
            }
          end
        end,
        current: proc {params[:hospital_type]},
        class: :hospital_type
      }
    end

  end
end
