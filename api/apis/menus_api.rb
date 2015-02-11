class MenusAPI < Grape::API

	get "menus" do 
		{
			title: "全部类别",
			data: [{
					template: "menus",
					menus:[{
						name: "热门",
						content: [{
							name: "手机挂号",
							link: ""
						}, {
							name: "热门月子中心",
							link: ""
						}]
					}, {
						name: "医院大全",
						content: [{
							name: "综合医院",
							link: ""
						}, {
							name: "全国体检",
							link: ""
						}]

					}
				]
				}]
			
		}
	end
end