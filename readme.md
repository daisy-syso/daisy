# Daisy

## 关于我
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

## 我的关注
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


## 我的关注详情
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

## 关注
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

