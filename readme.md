# Daisy

## 关于我[需登录]
```
api/aboutme
```
```
response
{
  "template": "accounts",
  "id": 10,
  "email": "111@111.com",
  "username": "dave",
  "authentication_token": "EuMAhdoJzyphW_QhJxYU"
}
```

## 可关注分类
```
GET api/follows/all_disease_info_types
```
```
response
{
  "肿瘤": [
    {
      "id": 5,
      "name": "肺癌"
    },
    {
      "id": 6,
      "name": "胃癌"
    },
    {
      "id": 7,
      "name": "肝癌"
    },
    {
      "id": 8,
      "name": "肠癌"
    },
    {
      "id": 9,
      "name": "乳腺癌"
    },
    {
      "id": 10,
      "name": "宫颈癌"
    }
  ],
  "男科": [
    {
      "id": 11,
      "name": "阳痿"
    },
    {
      "id": 12,
      "name": "前列腺疾病"
    },
    {
      "id": 13,
      "name": "不育"
    },
    {
      "id": 14,
      "name": "包皮包茎"
    }
  ],
  "妇科": [
    {
      "id": 15,
      "name": "乳腺增生"
    },
    {
      "id": 16,
      "name": "阴道炎"
    },
    {
      "id": 17,
      "name": "月经"
    },
    {
      "id": 18,
      "name": "流产"
    },
    {
      "id": 19,
      "name": "不孕"
    }
  ],
  "中医": [
    {
      "id": 20,
      "name": "针灸"
    },
    {
      "id": 21,
      "name": "艾灸"
    },
    {
      "id": 22,
      "name": "药膳"
    },
    {
      "id": 23,
      "name": "推拿"
    },
    {
      "id": 24,
      "name": "偏方"
    },
    {
      "id": 25,
      "name": "拔罐"
    },
    {
      "id": 26,
      "name": "煎药"
    }
  ],
  "糖尿病": [
    {
      "id": 28,
      "name": "糖尿病足"
    },
    {
      "id": 29,
      "name": "血糖检测"
    },
    {
      "id": 30,
      "name": "降糖药品"
    },
    {
      "id": 31,
      "name": "胰岛素"
    }
  ],
  "心脑血管": [
    {
      "id": 33,
      "name": "冠心病"
    },
    {
      "id": 34,
      "name": "高血压"
    },
    {
      "id": 35,
      "name": "心肌梗死"
    },
    {
      "id": 36,
      "name": "心脏病"
    },
    {
      "id": 37,
      "name": "心绞痛"
    },
    {
      "id": 38,
      "name": "心律失常"
    },
    {
      "id": 39,
      "name": "心肌病"
    },
    {
      "id": 40,
      "name": "高血脂"
    },
    {
      "id": 41,
      "name": "动脉硬化"
    }
  ]
}
```

## 我的关注[需登录]
```
GET api/follows
```
```
response
{
  "妇科": [
    {
      "id": 17,
      "name": "月经"
    },
    {
      "id": 18,
      "name": "流产"
    },
    {
      "id": 19,
      "name": "不孕"
    }
  ]
}
```


## 我的关注详情[需登录]
```
GET api/followsfollows?disease_info_type_id=16
```
```
response
{
  "data": [
    {
      "template": "infors/health_infors",
      "id": 30048,
      "name": "小心！泡温泉或惹来阴道炎“麻烦”",
      "source": "39健康网",
      "image_url": "http://7d9otw.com1.z0.glb.clouddn.com/normal/jiankangguanli.jpg",
      "is_top": false,
      "created_at": "2015-11-24",
      "type_name": "健康管理"
    },
    {
      "template": "infors/health_infors",
      "id": 30049,
      "name": "便前不洗手 阴道炎乘虚而入",
      "source": "39健康网",
      "image_url": "http://7d9otw.com1.z0.glb.clouddn.com/normal/jiankangguanli.jpg",
      "is_top": false,
      "created_at": "2015-08-11",
      "type_name": "健康管理"
    },
    {
      "template": "infors/health_infors",
      "id": 30050,
      "name": "你不知道的阴道炎“禁区”",
      "source": "39健康网",
      "image_url": "http://7d9otw.com1.z0.glb.clouddn.com/normal/jiankangguanli.jpg",
      "is_top": false,
      "created_at": "2015-08-06",
      "type_name": "健康管理"
    }
  ]
}
```

## 关注[需登录]
```
POST api/follows
```
```
request
{
  "disease_info_type_ids": "15,16,17,18,19"
}
```
```
response 201
{
  "info": "乳腺增生 已经被关注,阴道炎 已经被关注,月经 已经被关注,流产 已经被关注,不孕 已经被关注,"
}
```

## 取消关注[需登录]
```
DELETE api/follows
```
```
request
{
  "disease_info_type_ids": "15,16,17,18,19"
}
```
```
response 201
{
  "info": "已取消关注。"
}
```

## 获取视频分类
```
GET api/video_categories
```
```
response 200
{
  "data": [
    {
      "template": "video_categories",
      "id": 1,
      "name": "资讯"
    },
    {
      "template": "video_categories",
      "id": 2,
      "name": "医疗"
    },
    {
      "template": "video_categories",
      "id": 3,
      "name": "两性"
    },
    {
      "template": "video_categories",
      "id": 4,
      "name": "养生"
    },
    {
      "template": "video_categories",
      "id": 5,
      "name": "健身"
    },
    {
      "template": "video_categories",
      "id": 6,
      "name": "美容"
    },
    {
      "template": "video_categories",
      "id": 7,
      "name": "心理"
    },
    {
      "template": "video_categories",
      "id": 8,
      "name": "常识"
    },
    {
      "template": "video_categories",
      "id": 9,
      "name": "儿科"
    },
    {
      "template": "video_categories",
      "id": 10,
      "name": "老年"
    },
    {
      "template": "video_categories",
      "id": 11,
      "name": "宠物"
    },
    {
      "template": "video_categories",
      "id": 12,
      "name": "交流分享"
    }
  ]
}
```

## 根据视频分类Id获取视频信息
```
GET api/videos?video_category_id=#{video_category_id}&page=#{page}&per=#{per}
```
```
response 200
{
  "data": [
    {
      "template": "videos",
      "album_name": "痛风病人应该如何饮食-李小霞-慢病",
      "pic_url": "http://pic8.qiyipic.com/image/20160104/5d/dc/v_109913022_m_601.jpg",
      "create_time": "2016-01-04T15:25:58.000+08:00",
      "time_length": 153,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6u2gc.html"
    },
    {
      "template": "videos",
      "album_name": "痛风的危害有哪些",
      "pic_url": "http://pic2.qiyipic.com/image/20160104/12/04/v_109913042_m_601_m1.jpg",
      "create_time": "2016-01-04T13:28:47.000+08:00",
      "time_length": 160,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6qq18.html"
    },
    {
      "template": "videos",
      "album_name": "男子患干燥综合症 6年喝9吨水",
      "pic_url": "http://pic5.qiyipic.com/image/20160104/6f/5f/v_109912879_m_601.jpg",
      "create_time": "2016-01-04T13:27:12.000+08:00",
      "time_length": 74,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6qqng.html"
    },
    {
      "template": "videos",
      "album_name": "印度男脸长巨瘤被当象神",
      "pic_url": "http://pic0.qiyipic.com/image/20160104/48/d6/v_109912872_m_601.jpg",
      "create_time": "2016-01-04T13:25:42.000+08:00",
      "time_length": 63,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6qok8.html"
    },
    {
      "template": "videos",
      "album_name": "如何确诊痛风",
      "pic_url": "http://pic4.qiyipic.com/image/20160104/e2/ae/v_109913091_m_601_m1.jpg",
      "create_time": "2016-01-04T13:20:13.000+08:00",
      "time_length": 84,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6qnsk.html"
    },
    {
      "template": "videos",
      "album_name": "治疗痛风的最佳方法是什么",
      "pic_url": "http://pic2.qiyipic.com/image/20160104/07/66/v_109913116_m_601_m1.jpg",
      "create_time": "2016-01-04T13:18:27.000+08:00",
      "time_length": 54,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6qyfk.html"
    },
    {
      "template": "videos",
      "album_name": "急性痛风吃什么药好",
      "pic_url": "http://pic7.qiyipic.com/image/20160104/52/f9/v_109913124_m_601_m1.jpg",
      "create_time": "2016-01-04T13:18:08.000+08:00",
      "time_length": 52,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6qz30.html"
    },
    {
      "template": "videos",
      "album_name": "女童伤口包太紧致手指截除？",
      "pic_url": "http://pic8.qiyipic.com/image/20160104/42/6c/v_109912582_m_601.jpg",
      "create_time": "2016-01-04T10:41:56.000+08:00",
      "time_length": 121,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6rnyc.html"
    },
    {
      "template": "videos",
      "album_name": "健康解码：如何预防心脑血管疾病？",
      "pic_url": "http://pic3.qiyipic.com/image/20160104/1c/f4/v_109912547_m_601_m1.jpg",
      "create_time": "2016-01-04T10:32:44.000+08:00",
      "time_length": 219,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6rij0.html"
    },
    {
      "template": "videos",
      "album_name": "只穿丝袜 女子冻出脑膜炎",
      "pic_url": "http://pic8.qiyipic.com/image/20160104/69/22/v_109912304_m_601_m1.jpg",
      "create_time": "2016-01-04T10:30:18.000+08:00",
      "time_length": 194,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl6rpuw.html"
    },
    {
      "template": "videos",
      "album_name": "前列腺炎患者可以有性生活吗",
      "pic_url": "http://pic9.qiyipic.com/image/20160104/07/46/v_109912310_m_601_m1.jpg",
      "create_time": "2016-01-04T10:09:39.000+08:00",
      "time_length": 164,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7wm0o.html"
    },
    {
      "template": "videos",
      "album_name": "高盐也会引发心梗？",
      "pic_url": "http://pic8.qiyipic.com/image/20160104/28/96/v_109911619_m_601_m1.jpg",
      "create_time": "2016-01-04T08:29:22.000+08:00",
      "time_length": 123,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7y2ow.html"
    },
    {
      "template": "videos",
      "album_name": "女子体内藏2公斤“肝虫“成功手术切除",
      "pic_url": "http://pic6.qiyipic.com/image/20160103/4a/93/v_109910311_m_601.jpg",
      "create_time": "2016-01-03T17:49:10.000+08:00",
      "time_length": 94,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t7z4.html"
    },
    {
      "template": "videos",
      "album_name": "浙江百岁老人返老还童",
      "pic_url": "http://pic4.qiyipic.com/image/20160103/85/b3/v_109910306_m_601.jpg",
      "create_time": "2016-01-03T17:50:47.000+08:00",
      "time_length": 60,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t8vs.html"
    },
    {
      "template": "videos",
      "album_name": "中国男性秃顶总面积等于四分之一北京",
      "pic_url": "http://pic7.qiyipic.com/image/20160103/7c/56/v_109910297_m_601.jpg",
      "create_time": "2016-01-03T17:51:24.000+08:00",
      "time_length": 265,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t6c8.html"
    },
    {
      "template": "videos",
      "album_name": "一岁大婴儿呛入花生米险危及生命",
      "pic_url": "http://pic0.qiyipic.com/image/20160103/8f/85/v_109910289_m_601.jpg",
      "create_time": "2016-01-03T17:52:55.000+08:00",
      "time_length": 113,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t700.html"
    },
    {
      "template": "videos",
      "album_name": "湖北男子熬夜加班眼睛血管爆裂",
      "pic_url": "http://pic1.qiyipic.com/image/20160103/54/9b/v_109910279_m_601.jpg",
      "create_time": "2016-01-03T17:53:24.000+08:00",
      "time_length": 136,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t7uk.html"
    },
    {
      "template": "videos",
      "album_name": "男子寻刺激将13厘米玻璃瓶塞入肛门",
      "pic_url": "http://pic4.qiyipic.com/image/20160103/7d/89/v_109910270_m_601.jpg",
      "create_time": "2016-01-03T17:53:39.000+08:00",
      "time_length": 89,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t4yc.html"
    },
    {
      "template": "videos",
      "album_name": "拒做低头族 拥抱健康生活",
      "pic_url": "http://pic9.qiyipic.com/image/20160103/ca/8e/v_109910260_m_601.jpg",
      "create_time": "2016-01-03T17:54:09.000+08:00",
      "time_length": 149,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t61w.html"
    },
    {
      "template": "videos",
      "album_name": "2015那些影响生活的谣言",
      "pic_url": "http://pic7.qiyipic.com/image/20160103/d3/b1/v_109910253_m_601.jpg",
      "create_time": "2016-01-03T17:54:37.000+08:00",
      "time_length": 189,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t640.html"
    },
    {
      "template": "videos",
      "album_name": "晚霞之冬季老人皮肤护理（六）",
      "pic_url": "http://pic9.qiyipic.com/image/20160103/5c/0b/v_109909905_m_601.jpg",
      "create_time": "2016-01-03T17:55:12.000+08:00",
      "time_length": 891,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7t4c8.html"
    },
    {
      "template": "videos",
      "album_name": "聚健康之一味单方显奇效（1)",
      "pic_url": "http://pic1.qiyipic.com/image/20160103/fd/9d/v_109907314_m_601.jpg",
      "create_time": "2016-01-03T17:55:35.000+08:00",
      "time_length": 2043,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7tex4.html"
    },
    {
      "template": "videos",
      "album_name": "健康早知道之五毛小食品的危害",
      "pic_url": "http://pic8.qiyipic.com/image/20160103/65/b9/v_109905881_m_601.jpg",
      "create_time": "2016-01-03T17:56:46.000+08:00",
      "time_length": 1683,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7tfgk.html"
    },
    {
      "template": "videos",
      "album_name": "晚霞之冬季老人皮肤护理（四）",
      "pic_url": "http://pic6.qiyipic.com/image/20160103/8d/15/v_109905799_m_601.jpg",
      "create_time": "2016-01-03T17:56:58.000+08:00",
      "time_length": 844,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7tcx0.html"
    },
    {
      "template": "videos",
      "album_name": "您吃对了吗：冬补气血小窍门",
      "pic_url": "http://pic6.qiyipic.com/image/20160103/88/5b/v_109905780_m_601.jpg",
      "create_time": "2016-01-03T17:57:10.000+08:00",
      "time_length": 1104,
      "html5_play_url": "http://m.iqiyi.com/v_19rrl7td9c.html"
    }
  ]
}
```

## 健康资讯
```
GET api/infors/health_infors.json
```
```
response 200
```
多加两个关于视频的对象，
video_category， 所属视频的分类，调用接口api/videos?video_category_id=#{video_category_id}&page=#{page}&per=#{per} 时使用。
top_videos 每个分类的两个视频数据。
```