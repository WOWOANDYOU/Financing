<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	$(document)
			.ready(
					function() {
						/* 将 container div高度设置为 屏幕的高度 自动适应 */
						$("#container").css("height", $(document).height());
						$("#before_login_search_div").click(function() {
							alert("你还没登录，请先登录后,再查询个人账簿信息");
						});

						/* jq时间插件 */
						$(".date_picker").date_input();

						/* 如果用户还没登录  那么 主页面 就显示 一张图片 给他好了 */
						var islogin = '${sessionScope.user.username}';
						if (islogin == '') {
							$("#tab_main_content").css("height", "500px");
							$("#tab_main_content").css("background-image","url(${pageContext.request.contextPath}/img/main.jpg)");
							$("#tab_main_content").css("background-size","cover");/* 使图片自适应 div大小 */
						}
						/* 用来 判断 是要显示 登录 还是 注册 框 以便 用jq做动态控制 */
						var singInUp = "";
						/* 打开登录/注册 模态框  共用 一个 模态框 用 jq控制  减少 代码量 */
						$("#before_login_singin_modal").click(function() {
							$("#myModal_singInUp").modal('show');
							singInUp = "singin";
							$("#modal_singInUpTitle").text("登录理财通");
							$("#modal_singInUpForm").attr("action","${pageContext.request.contextPath }/user/login.action");
							/* 如果是登录的话 那么就 将 后面的 两个 输入框 确定密码 输入邮箱 隐藏 */
							$("#modal_singInUp_pad2").hide();
							$("#modal_singInUp_email").hide();
							$("#modal_singInUpSubmit_btn").text("登录理财通");
						});

						$("#before_login_singout_modal").click(function(){
							$("#myModal_singInUp").modal('show');
							singInUp = "singup";
							$("#modal_singInUpTitle").text("加入理财通");
							$("#modal_singInUpForm").attr("action","${pageContext.request.contextPath }/user/register.action");
							/* 如果是登录的话 那么就 将 后面的 两个 输入框 确定密码 输入邮箱显示*/
							$("#modal_singInUp_pad2").show();
							$("#modal_singInUp_email").show();
							$("#modal_singInUpSubmit_btn").text("加入理财通");
							});

						$("#modal_singInUpSubmit_btn").click(function() {
											var username = $("#modal_singInUp_username").val();
											var password = $("#modal_singInUp_pad").val();
											var password2 = $("#modal_singInUp_pad2").val();
											var email = $("#modal_singInUp_email").val();
											if (singInUp == "singin") {
												if (username == null || username == "" || $.trim(username).length == 0) {
													alert("请输入用户名");
													return false;
												}
												if (password == null || password == "" || $.trim(password).length == 0) {
													alert("请输入密码");
													return false;
												}
											}
											if (singInUp == "singup") {
												if (username == null || username == "" || $.trim(username).length == 0) {
													alert("请输入用户名");
													return false;
												}
												if (password == null|| password == "" || $.trim(password).length == 0) {
													alert("请输入密码");
													return false;
												}
												if (password2 == null || password2 == "" || $.trim(password2).length == 0) {
													alert("请确认密码");
													return false;
												}
												if (email == null || email == "" || $.trim(email).length == 0) {
													alert("请输入邮箱");
													return false;
												}
												if (password != password2) {
													alert("两次密码不一致");
													return false;
												}
											}
											return true;
										});

						/* 由于 好多 模态框是可以 复用的 所以 用jq 来 改变 以便需要变化的值 以减少 代码量 */
						/* 添加 消费 类别 以及 收入类别 共用一个模态框 */
						var modal_spend_income = "";

						/* 点击 添加 消费类别 弹出 添加 消费类别的模态框  */
						$("#addSpendCateId").click(function() {
							$("#myModal_addCateModal").modal('show');
							modal_spend_income = "spendCate";
							$("#addCategoryTitle").text("添加消费类型");
						});

						$("#addIncomeCateId").click(function() {
							$("#myModal_addCateModal").modal('show');
							modal_spend_income = "incomeCate";
							$("#addCategoryTitle").text("添加收入类型");
						});

						$("#modal_addCate_submitbtn").click(function() {
							var Cateval = $("#modal_addCate_name").val();
							if (Cateval == null || Cateval == '' || $.trim(Cateval).length == 0) {
								alert("请输入类别名");
								return false;
							} else {
								if (modal_spend_income == "spendCate") {
									/* 调用 ajax 函数 提交 */
									var cateurl = "${pageContext.request.contextPath }/spend/addSpendCate.action";
									/* 传递的数据  Cateval 以及 往哪个select表标签 添加 option节点 */
									var spendNode = "select_spend_cate";
									/* 调用ajax函数 */
									ajaxfunctionCate(cateurl,
											Cateval, spendNode);
								}
								if (modal_spend_income == "incomeCate") {
									var cateurl = "${pageContext.request.contextPath }/income/addIncomeCate.action";
									var incomeNode = "select_income_cate";
									ajaxfunctionCate(cateurl,
											Cateval, incomeNode);
								}
							}
						});

						$("#submit_spend_info_btn").click(function() {
							var spendnum = $("#spend_input_div").val();
							var spendcate = $("#select_spend_cate").val();
							if (spendnum == null || spendnum == '' || $.trim(spendnum).length == 0) {
								alert("请输入金额");
								return false;
							}
							if (spendcate == "选择类别" || spendcate == null || spendcate == "" || $.trim(spendcate).length == 0) {
								alert("请选择类别");
								return false;
							}
						});
						$("#submit_income_info_btn").click(function() {
							var incomenum = $("#income_input_div").val();
							var incomecate = $("#select_income_cate").val();
							if (incomenum == null || incomenum == '' || $.trim(incomenum).length == 0) {
								alert("请输入金额");
								return false;
							}
							if (incomecate == "选择类别" || incomecate == null || incomecate == "" || $.trim(incomecate).length == 0) {
								alert("请选择类别");
								return false;
							}
						});
						
						/*jq 动态 控制字体  */
						$("#findDateRecordBtn").click(function(){
							var inputval = $("#datatimeo").val();
							var dateArray = inputval.split("-");
							if(inputval!=null && inputval!=""&& $.trim(inputval).length!=0 && dateArray.length==3){
								$("#calcuteYearId").text(dateArray[0]+"年");
								$("#calcuteMonthId").text(dateArray[1]+"月");
								//调用 ajax 函数
								var urlPath = "${pageContext.request.contextPath }/findDateRecord.action";
								var dataArray = [inputval,${sessionScope.user.id}];
								ajaxfunctionGetData(urlPath,dataArray);
								$("#personRecord_body_detail_alltable").hide();//点击 查询 显示 具体 那天的信息 并隐藏 全部信息的div 在 上面 有实现 
								$("#personRecord_body_detail_datetable").show();
								
								//调用 ajax  函数 显示 该用户 当天 收入情况
								ajaxCalcutePageTotals("date_table",inputval);
							}else{
								alert("请点击选择日期输入框 选择日期 ！");
							}
							
						});
						
						//加载完页面后 要 将 personRecord_body_detail_datetable div隐藏 
						$("#personRecord_body_detail_datetable").hide();
						
						$("#showDetailRecordbtn").click(function(){
							 //显示 分页 按钮
							//$("#pageNavId").show();
							$("#personRecord_body_detail_datetable").hide();
							$("#personRecord_body_detail_alltable").show();
							$("#pageNavId").show();
							//调用 ajax 查后台 分页数据
							ajaxCalcutePageTotals("personRecord_table","");
						});
						$("#a_id_record").click(function(){
							$("#personRecord_body_detail_alltable").show();
							$("#personRecord_body_detail_datetable").hide();
						});
						
						//给Date对象 定义一个format函数
						Date.prototype.Format = function(fmt)     
						{   
						//author:wangweizhen  
						  var o = {     
						    "M+" : this.getMonth()+1,                 //月份     
						    "d+" : this.getDate(),                    //日  
						    "h+" : this.getHours(),                   //小时     
						    "m+" : this.getMinutes(),                 //分     
						    "s+" : this.getSeconds(),                 //秒     
						    "q+" : Math.floor((this.getMonth()+3)/3), //季度     
						    "S"  : this.getMilliseconds()             //毫秒     
						  };     
						  if(/(y+)/.test(fmt))     
						    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));     
						  for(var k in o)     
						    if(new RegExp("("+ k +")").test(fmt))     
						  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));     
						  return fmt;     
						};  
						
						//刚进来 不显示 详细信息 表格的分页 按钮  点击 显示 所有 信息按钮后 才给显示
						//$("#pageNavId").hide();
						
						var totalPages = 0;//总页数 
						var currentPage = $("#personRecordPage").val();//当前页
						
						//查询 后台 获取总页数   在登录的状态下
						var singinOrNot = '${sessionScope.user }';
						if(''!=singinOrNot){
							ajaxCalcutePageTotals("personRecord_table","");
						}
						
						$("#prePagebtnId_all").click(function(){//当 前一页按钮 点击后 调用ajax 查询 后台数据
							var isGoOn = isPageBorderPre("personRecordPage","prePagebtnId_all");
							//console.log("边界 判断"+isGoOn);                  
							if(isGoOn){//不是 边界 时调用函数 先将 上一页按钮 可用
								$("#prePagebtnId_all").removeClass("disabled");
								var currentPage = $("#personRecordPage").val();
								currentPage--;//因为 要查找上一页数据
								ajaxPagefunction(currentPage,"personRecordPage","personRecord_table","");
							}
							
						});
						
						$("#nextPagebtnId_all").click(function(){
							var isGoOn = isPageBorderNext("personRecordPage","nextPagebtnId_all");
							//console.log("边界 判断"+isGoOn);
							if(isGoOn){//不是 边界 时调用函数 
								$("#nextPagebtnId_all").removeClass("disabled");
								$("#prePagebtnId_all").removeClass("disabled");
								
								var currentPage = $("#personRecordPage").val();
								currentPage++;//因为 要查找上一页数据
								ajaxPagefunction(currentPage,"personRecordPage","personRecord_table","");
							}
						});
						
						$("#prePagebtnId_date").click(function(){
							var isGoOn = isPageBorderPre("recordResultPage","prePagebtnId_date");
							//console.log("边界 判断"+isGoOn);                  
							if(isGoOn){//不是 边界 时调用函数 先将 上一页按钮 可用
								//$("#prePagebtnId_all").removeClass("disabled");
								var currentPage = $("#recordResultPage").val();
								currentPage--;//因为 要查找上一页数据
								ajaxPagefunction(currentPage,"recordResultPage","date_table",$("#datatimeo").val());
							}
						});
						$("#nextPagebtnId_date").click(function(){
							var isGoOn = isPageBorderNext("recordResultPage","nextPagebtnId_date");
							//console.log("边界 判断"+isGoOn);                  
							if(isGoOn){//不是 边界 时调用函数 先将 下一页按钮 可用
								//$("#prePagebtnId_all").removeClass("disabled");
								var currentPage = $("#recordResultPage").val();
								currentPage++;//因为 要查找下一页数据
								ajaxPagefunction(currentPage,"recordResultPage","date_table",$("#datatimeo").val());
							}
						});
						
						$("#yearaddId").click(function(){
							var year = $("#yearNumId").text();
							year++;
							$("#yearNumId").text(year);
							$("#titleYearId").text(year);
							
							//调用 绘图 插件
							ajaxGetYearDataGraph(year);
						});
						$("#yearsubId").click(function(){
							var year = $("#yearNumId").text();
							year--;
							$("#yearNumId").text(year);
							$("#titleYearId").text(year);
							//调用 绘图 插件
							ajaxGetYearDataGraph(year);
						});
						
						$("#yearsubId2").click(function(){
							var year = $("#yearNumId2").text();
							year--;
							$("#yearNumId2").text(year);
							$("#titleYearId2").text(year);
						});
						//点击 年份 增加 年份数 增加
						$("#yearaddId2").click(function(){
							var year = $("#yearNumId2").text();
							year++;
							$("#yearNumId2").text(year);
							$("#titleYearId2").text(year);
						});
						
						$("#monthsubId2").click(function(){
							var month = $("#monthNumId2").text();
							if(month == 1){//当 月份 为 1 时  再点击 减按钮 那么 变为 上一年 的12月份 
								$("#monthNumId2").text("12");
								$("#titleMonthId").text("12");
								var year = $("#yearNumId2").text();
								year--;
								$("#yearNumId2").text(year);
								$("#titleYearId2").text(year);
							}else{
								month--;
								$("#monthNumId2").text(month);
								$("#titleMonthId").text(month);
							}
						});
						
						$("#monthaddId2").click(function(){
							var month = $("#monthNumId2").text();
							if(month == 12){//当 月份 为 12 时  再点击 加按钮 那么 变为 下一年 的1月份 
								$("#monthNumId2").text("1");
								$("#titleMonthId").text("1");
								var year = $("#yearNumId2").text();
								year++;
								$("#yearNumId2").text(year);
								$("#titleYearId2").text(year);
							}else{
								month++;
								$("#monthNumId2").text(month);
								$("#titleMonthId").text(month);
							}
						});
						
						$("#yearsubId3").click(function(){
							var year = $("#yearNumId3").text();
							year--;
							$("#yearNumId3").text(year);
							$("#titleYearId3").text(year);
							//调用 ajax 函数
							ajaxGetMonthDataGrahp(year,"real_spendAndIncomeBody3","");
						});
						$("#yearaddId3").click(function(){
							var year = $("#yearNumId3").text();
							year++;
							$("#yearNumId3").text(year);
							$("#titleYearId3").text(year);
							//调用 ajax 函数
							ajaxGetMonthDataGrahp(year,"real_spendAndIncomeBody3","");
						});
						
						//点击 查看 按钮 显示 饼图
						$("#yearMonthBtnId").click(function(){
							ajaxGetMonthDataGrahp($("#yearNumId2").text(),"real_spendAndIncomeBody2",$("#monthNumId2").text());
						});
						
						//点击显示 收支报表后  调用 ajax 给 heighchart 提供年度 收支情况 数据
						$("#showSpendIncomeGraphId").click(function(){
							ajaxGetYearDataGraph($("#yearNumId").text());
						});
						 
						//点击月份消费比 后 调用 ajax 给 heighchart 提供年度具体某月的 消费比重 情况 数据
						$("#showMonthSpendGraphId").click(function(){
							ajaxGetMonthDataGrahp($("#yearNumId2").text(),"real_spendAndIncomeBody2",$("#monthNumId2").text());
						});
						
						//点击年度 消费 比后 调用 ajax 给 heighchart 提供年度 消费比重 情况 数据
						$("#showYearSpendGraph").click(function(){
							ajaxGetMonthDataGrahp($("#yearNumId3").text(),"real_spendAndIncomeBody3","");
						});
						
					});
					
//获取 绘制 饼图 某年 某月 数据
function ajaxGetMonthDataGrahp(yearNum,graphDiv,monthNum){
	var title2 = yearNum+"年度消费各类别金额占有比例";
	if(monthNum!=null && monthNum!=""){
		title2 = yearNum+"年度"+monthNum+"月份消费各类别金额占有比例"
	}
	 
	$.ajax({
		url:"${pageContext.request.contextPath }/yearAndMonthGraph.action",
		type:"get",
		dataType:"json",
		data:"yearNum="+yearNum+"&userId=${sessionScope.user.id }"+"&monthNum="+monthNum,
		success:function(data){
			console.log(data);
			if(data==null || data.length==0){
				$('#'+graphDiv).html("<font style='color:red;'><h3 align='center'>没有数据</h3></font>"); 
			}else{
				var chart = {
		       plotBackgroundColor: null,
		       plotBorderWidth: null,
		       plotShadow: false
		   };
		   var title = {
		      text: title2   
		   };      
		   var tooltip = {
		      pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
		   };
		   var plotOptions = {
		      pie: {
		         allowPointSelect: true,
		         cursor: 'pointer',
		         dataLabels: {
		            enabled: true,
		            format: '<b>{point.name}%</b>: {point.percentage:.1f} %',
		            style: {
		               color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
		            }
		         }
		      }
		   };
		   //计算比例
		   var alltotal = 0;
		   for(var i=0;i < data.length;i++){
		   	alltotal+=data[i].totalNum;
		   }
		   var dataArray = [];
		   for(var i=0;i < data.length;i++){
		   	var temp1 = data[i].cate_name;
		   	var temp2 = data[i].totalNum/alltotal;
		   		if(i!=data.length-1){
		   			dataArray.push({name:temp1,y:temp2});
		   		}else{
		   			dataArray.push({name:temp1,y:temp2,sliced:true,selected:true});
		   		}
	   			
		   }
		   //console.log(dataArray);
		   var series= [{
		      type: 'pie',
		      name: '消费类别金额比例',
		      data: dataArray
		   }];     
		   var json = {};   
		   json.chart = chart; 
		   json.title = title;     
		   json.tooltip = tooltip;  
		   json.series = series;
		   json.plotOptions = plotOptions;
		   $('#'+graphDiv).highcharts(json); 
			}
			
			
		},
		error:function(){}
	});
	
}
//获取 绘制 图标 数据 的ajax函数
function ajaxGetYearDataGraph(yearNum){
	$.ajax({
		url:"${pageContext.request.contextPath }/yearGraph.action",
		type:"get",
		dataType:"json",
		data:"yearNum="+yearNum+"&userId=${sessionScope.user.id }",
		success : function(data){
		console.log(data);
			var title = {
			      text: yearNum+'年度收支情况'   
		   };
		   var subtitle = {
		      text: 'Source: financing.com'
		   };
		   var xAxis = {
		      categories: ['一月', '二月', '三月', '四月', '五月', '六月',
		         '七月', '八月', '九月', '十月', '十一月', '十二月']
		   };
		   var yAxis = {
		      title: {
		         text: '人民币￥ (\元)'
		      }
		   };
		   var plotOptions = {
		      line: {
		         dataLabels: {
		            enabled: true
		         },   
		         enableMouseTracking: false
		      }
		   };
		   var Arrayspend = new Array(12);
		   var Arrayincome = new Array(12);
		   //将对应 月份 数据 赋值到 对应 数组下标
		   for(var i=0;i < Arrayspend.length;i++){
		   		Arrayspend[i] = 0;
		   }
		   for(var k=0;k < data.spendNum.length;k++){
		   	var a = data.spendNum[k].month_num;
		   	a--;
		   	Arrayspend[a] = data.spendNum[k].totalNum;
		   }
		   
		   for(var i=0;i < Arrayincome.length;i++){
		   		Arrayincome[i] = 0;
		   }
		   for(var i=0;i < data.incomeNum.length;i++){
		   	var a = data.spendNum[i].month_num;
		   	a--;
		   	Arrayincome[a] = data.incomeNum[i].totalNum;
		   }
		   
		   //console.log("支出:"+Arrayspend+"  收入:"+Arrayincome);
		   var series= [{
		         name: '支出',
		         data: Arrayspend,
		         color:'red'
		      }, {
		         name: '收入',
		         data: Arrayincome
		      }
		   ];
		   
		   var json = {};
		
		   json.title = title;
		   json.subtitle = subtitle;
		   json.xAxis = xAxis;
		   json.yAxis = yAxis;  
		   json.series = series;
		   json.plotOptions = plotOptions;
		  
		   $('#real_spendAndIncomeBody').highcharts(json);
		},
		error : function(){}
	});
	
}

//定义一个全局变量  记住 总页数
var globalTotalPages = 0;

//先要 从后台 查一共有几条记录数 用于后面的判断 有点 蛋疼 。。。。。这个是可以优化的 
function ajaxCalcutePageTotals(tableId,date){
	$.ajax({
			url:"${pageContext.request.contextPath }/recordInfo/queryAllrecord.action",
			type:"post",
			data:"userId=${sessionScope.user.id}&currentPage=1&date="+date,//第一次 默认 第一页
			dataType:"json",//服务器返回数据 为 json数据
			success:function(data){
				globalTotalPages = data.totalPages;
				console.log("查询后台 知总页数为： "+globalTotalPages+" 当前页"+$("#personRecordPage").val()); //获取成功
				if(0==globalTotalPages){//如果后台 返回的数据 是空的 即是 数据库中 没有数据 那么 提示 没有数据 并将 翻页 按钮隐藏
					$("#"+tableId+" tbody").html("<h3><font style='color: red;' align='center'>没有数据</font></h3>");
					$("#pageNavId").hide();
				}else{
					//将 从后台 查询到的数据 返回给 前端展示出来  但是 展现出来前 需要 将 日期 转换为 yyyy-MM-dd格式
					var dateArrayTem = [];//定义一个 接收 临时 日期数组
					for(var i=0;i < data.pageResult.length;i++){
						dateArrayTem.push(new Date(data.pageResult[i].date).Format("yyyy-MM-dd"));
					} 
					$("#"+tableId+" tbody").html("");
					for(var i=0;i < data.pageResult.length;i++){
						$("#"+tableId+" tbody").append("<tr><td>"+data.pageResult[i].number+"</td><td>"+data.pageResult[i].cate_name+"</td><td>"+data.pageResult[i].comment+"</td><td>"+dateArrayTem[i]+"</td></tr>");
					}
					//第一页 所以 上一页 按钮不可以点击
					//如果 当前页面是第一页 那么 上一页 按钮 那就消失吧
					//$("#prePagebtnId_all").addClass("disabled");
				}
			},
			error:function(){
			}
		});
}

//判断是否是上边界  页面 边界
function isPageBorderPre(currentPageId,btnId){
	var currentpage = $("#"+currentPageId).val();
		//console.log("当前页面 wowowo "+currentpage);
		if(currentpage==1){
			//如果 当前页面是第一页 那么 上一页 按钮禁止点击 并 return;
			//$("#"+btnId).addClass("disabled");
			alert("当前是第一页 ，没有上一页数据");
			return false;
		}
		return true;
}
//判断 是否是 下边界 
function isPageBorderNext(currentPageId,btnId){
	var currentpage = $("#"+currentPageId).val();
		//console.log("当前页面 wowowo "+currentpage);		
		if(currentpage==globalTotalPages){
			//如果 当前页面是第最后一页 那么 下一页 按钮禁止点击 ;
			//$("#"+btnId).addClass("disabled");
			alert("哈哈哈哈,数据显示完了，没有下一页了");
			return false;
		}
		return true;
}

	//分页 jq+ajax 实现 函数  主要  参数 currentPage 告诉 后台 我要找 第几页的数据 （调用 该函数 前 先 调用 边界判断 函数 只有 在 不是 边界的情况下 才调用 该函数）
	function ajaxPagefunction(currentPage,currentPageId,tableId,date){
		//用户登录页面 执行 ajax函数 去查找 该用户 对应的recordInfo表中 有多少条数据 可以显示 几页 规定 每页 5条数据
		$.ajax({
			url:"${pageContext.request.contextPath }/recordInfo/queryAllrecord.action",
			type:"post",
			data:"userId=${sessionScope.user.id}&currentPage="+currentPage+"&date="+date,
			dataType:"json",//服务器返回数据 为 json数据
			success:function(data){
				//操作成功后 更新  当前页标签中
				$("#"+currentPageId).val(currentPage);
				//返回的json 数组 里边有 查询到的 第一页 数据 以及 该用户 的所有记录可以分为几页 
				//console.log(data);
				
				//将 从后台 查询到的数据 返回给 前端展示出来  但是 展现出来前 需要 将 日期 转换为 yyyy-MM-dd格式
				var dateArrayTem = [];//定义一个 接收 临时 日期数组
				for(var i=0;i < data.pageResult.length;i++){
					dateArrayTem.push(new Date(data.pageResult[i].date).Format("yyyy-MM-dd"));
				} 
				//显示 新页面数据前 先要 将当前页面数据 清空 然后拼接 新数据
				$("#"+tableId+" tbody").html("");
				for(var i=0;i < data.pageResult.length;i++){
					$("#"+tableId+" tbody").append("<tr><td>"+data.pageResult[i].number+"</td><td>"+data.pageResult[i].cate_name+"</td><td>"+data.pageResult[i].comment+"</td><td>"+dateArrayTem[i]+"</td></tr>");
				}
			}
		});
	}
	
	function ajaxfunctionCate(cateurl, Cateval, Node) {
		$.ajax({
			url : cateurl,/* 发送给服务器的url */
			type : "post",
			/* data:{"username":$(this).val()}, *//* 发送给服务器的数据 json数据 */
			data : JSON.stringify({
				"name" : Cateval
			}),
			dataType : "json", /* 预期的服务器响应的数据 */
			contentType : "application/json;charset=utf-8",/* 发送数据给服务器时所用的内容类型	*/
			success : function(data) { /* 当请求成功时运行的函数 */
				if (data != null && data.name != null && data.name != "none") {
					$("#myModal_addCateModal").modal('hide');
					$("#" + Node).append(
							"<option value="+data.value+">" + data.name
									+ "</option>");
				}
			},
			error : function(data) {
			}
		});
	}
	
	
	//datastr 是一个 数组 记录 了 后台需需要的数据
	function ajaxfunctionGetData(urlPath,datastr){
		$.ajax({
			url:urlPath,
			type:"post",
			data:JSON.stringify({
				"date":datastr[0],  
 				"user_id":datastr[1]
			}),
			dataType:"json",
			contentType:"application/json;charset=utf-8",
			success:function(data){
		console.log(data);
		//console.log(new Date(data.incomelist[0].date).Format("yyyy-MM-dd"));
		// 调用 前面给 Date类型定义的format 函数   进行 毫秒值 转换为 日期格式  console.log(data[0].comment+" "+new Date(data[0].date).Format("yyyy-MM-dd"));
				//根据 data 做控制     
				if(data.spendnum!=null || data.spendnum!=""){
					$("#table1_spendId").text(data.spendnum);
				}
				if(data.incomenum!=null || data.incomenum!=""){
					$("#table1_incomeId").text(data.incomenum);
				}
				if(data.restnum!=null || data.restnum!=""){
					$("#table1_inOrOutId").text(data.restnum);
				}
				$("#person_find_result_date").text($("#datatimeo").val());
				$("#person_find_result_spend").text("共支出(￥):-"+data.dateSpendNum);
				$("#person_find_result_income").text("共收入(￥):+"+data.dateIncomeNum);
			},
			error:function(data){
			}
		});
	}
	
	 
	