class AllAPI < Grape::API

	get "all" do 
		{
			title: "全部类别",
			data: [
				{
					template: "all",
					id: 52,
					name: "败血症",
					image_url: "http://syso.qiniudn.com/diseases/201412151225373124476.jpg",
					desc: "败血症是指致病菌或条件致病菌侵入血循环，并在血中生长繁殖，产生毒素而发生的急性全身性感染。　　败血症的治疗：尽早使用广谱抗生素，联合用药给予高蛋白、高热量、高维生素饮食以保障营养。可静脉给予丙种球蛋白或少量多次输入血浆、全血或白蛋白。感染中毒者可在足量应用有效抗生素的同时给予肾上腺皮质激素短程治疗。 收起↑",
					params: "type=134"
				}
			]
		}
	end
end