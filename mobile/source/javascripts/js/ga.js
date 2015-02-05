
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','../www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-48942370-1', 'boai.com');
  ga('send', 'pageview');
function chat(){
	var p = arguments[0]?arguments[0]:'noposition';
	ga('send','pageview','chat/'); //ga  标示
	ga('send','event','chat','click',p);
	openZoosUrl('chatwin');  //商务通默认的链接	
}
function tel(p){	
	if(p.indexOf('wap')>-1&&p.indexOf('gh')>-1){	//手机 预约页面点击		
		ga('send','pageview','guahao/');
	}
	else if(p.indexOf('wap')>-1&&p.indexOf('tel')>-1){  //手机 手机直呼
		ga('send','pageview','call/');
	}	
	else if(p.indexOf('pc')>-1&&p.indexOf('gh')>-1){	//电脑 预约页面点击
		ga('send','pageview','guahao/');
	}
	else if(p.indexOf('pc')>-1&&p.indexOf('qq')>-1){	//电脑 QQ点击
		ga('send','pageview','qq/');
	}
	else if(p.indexOf('pc')>-1&&(p.indexOf('call')>-1)||p.indexOf("tel")>-1){	//电脑 网络电话点击 
		ga('send','pageview','pctel/');
	}
	else if(p.indexOf('pc')>-1&&p.indexOf('shangqiao')>-1){ //电脑 商桥点击
		ga('send','pageview','shangqiaoga/');
	};			
   ga('send','event','tel','click',p);//底部电话咨询
}



function msgOnline(method,position){
	  switch (method){
		  case 'chat':
			  ga('send','pageview','chat/'); //ga  标示
			  ga('send','event',method,'click',position);
			  //swtnote();
			  openZoosUrl('chatwin');  //商务通默认的链接	
			  break;
		  case 'guahao':
			　ga('send','pageview','guahao/'); //ga  标示
			 ga('send','event',method,'click',position);
			  break;
		  case 'qq':
			　ga('send','pageview','qq/'); //ga  标示
			 ga('send','event',method,'click',position);
			  break;
		  case 'tel':
			　ga('send','pageview','tel/'); //ga  标示
			 ga('send','event',method,'click',position);
			  break;
		  case 'call':
			　ga('send','pageview','call/'); //ga  标示
			 ga('send','event',method,'click',position);
			  break;
		 case 'callback':
		 	  ga('send','pageview','callback/'); //ga  标示
			   ga('send','event',method,'click',position);
		 	  break;
		 case 'shangqiao':
		 	  ga('send','pageview','shangqiao/'); //ga  标示
			   ga('send','event',method,'click',position);
			  break;		
		 case 'taobao':
		 	  ga('send','pageview','taobao/'); //ga  标示
			   ga('send','event',method,'click',position);
			  break;
		 case 'close':
		 	  ga('send','pageview','close/'); //ga  标示
			   ga('send','event',method,'click',position);
			  break;
		  case 'direct':
			  ga('send','pageview','chat/'); //ga  标示
			   ga('send','event',method,'click',position);
			  break;
		  case 'loadmore':
			  ga('send','pageview','loadmore/'); //ga  标示
			   ga('send','event',method,'click',position);
			  break;
		default:
			  break;
		
	  }
}

//function swtnote(){
//   if(confirm("由于线咨询组件升级，点击确定后将使用QQ咨询")){
//    	window.location='../wpa.b.qq.com/cgi/wpa.php@ln=1&key=XzkzODA1OTQwM18xNzg1MzZfNDAwNjk4ODE5OF8yXw';
//   }
//}
