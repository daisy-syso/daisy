//取得cookies
function getCookie(c_name) {
    var arr = document.cookie.split('; ');
    for(var i=0; i<arr.length; i++) {
        var arr2 = arr[i].split('=');
        if(arr2[0] == c_name) {
			return unescape(arr2[1]);
		}
    }
    return "";
}
//设置cookies
function setCookie(name, value, expiredays) {
    var oDate = new Date();
    oDate.setDate(oDate.getDate() + expiredays);
    document.cookie = name+'='+value+';expires='+oDate+';path=/';
}
//设置清除cookies
function clearCookie(c_name){  
 setCookie(c_name,"", -1);  
}
function setHistory(c_name,value,num,expiredays){
	if(value!=""){
		expiredays==null?expiredays=7:expiredays=expiredays;
		num==null?num=20:num=parseInt(num);
		var temp = getCookie(c_name);	
		if(temp!=""){		
			var arr = new Array();			
			arr = temp.split(",").reverse().slice(0,num).reverse();
			/***====== 判断字符串是否在数组中 Start ======***/		
			var idx = arr.indexOf(value);
			if (idx != -1) {
				//alert("有")
			}else{
				var value = arr.toString() +','+ value;	
				setCookie(c_name,value,expiredays);
				//alert("木有")
			}
			/***====== 判断字符串是否在数组中 End ======***/
		}else{
			setCookie(c_name,value,expiredays);
		}
	}
}
function getHistory(c_name,obj){	
	var temp = getCookie(c_name);
	//var obj = document.getElementById("obj");
	var html = "";
	if(temp!=""){		
		var arr = new Array();
		arr = temp.split(",").reverse();
		for(i in arr){
			var url = "search.php@keyword="+arr[i];
			html += '<a href="'+url+'">'+arr[i]+'</a>';
		}
		obj.html(html);
	}else{
		obj.html("<a rel='nofollow' target='_self'>暂无记录</a>");
	}
}