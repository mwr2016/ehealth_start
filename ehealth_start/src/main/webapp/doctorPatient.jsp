<%-- 我的病人页面，显示所有病人列表。显示组别、分页。——by liulu --%>
<%@ page language="java" pageEncoding="utf-8"%> 
<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE">  
<% 
 request.setCharacterEncoding("UTF-8"); 
 response.setCharacterEncoding("UTF-8"); 
 response.setContentType("text/html; charset=UTF-8"); 
%> 
<%
	//变量声明
	java.sql.Connection sqlCon; //数据库连接对象
	java.sql.Statement sqlStmt; //SQL语句对象
	java.sql.ResultSet sqlRst; //结果集对象
	java.lang.String strCon;//数据库连接字符串
	java.lang.String strSQL;//SQL语句
	int intPageSize; //一页显示的记录数
	int intRowCount;//记录总数
	int intPageCount;//总页数
	int intPage;//待显示页码
	java.lang.String strPage;
	int i;
	//设置一页显示的记录数
	intPageSize=3;
	//取得待显示页码
	strPage=request.getParameter("page");
	if(strPage==null){//表明在QueryString中没有page这一个参数，此时显示第一页数据
	intPage=1;
	}
	else{//将字符串转换成整型
	intPage=java.lang.Integer.parseInt(strPage);
	if(intPage<1)intPage=1;
	}
	//装载JDBC驱动程序
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	//设置数据库连接字符串
	strCon="jdbc:mysql://101.201.40.158:3306/ehealth";
	//连接数据库
	sqlCon=java.sql.DriverManager.getConnection(strCon,"root","123456");
	//创建一个可以滚动的只读的SQL语句对象
	sqlStmt=sqlCon.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_READ_ONLY);
    //获取医生id 
    String userLogined=(String)session.getAttribute("userTel");
	//准备SQL语句
	strSQL="SELECT * FROM mypatient where doctorId='"+ userLogined +"'";
	//执行SQL语句并获取结果集
	sqlRst=sqlStmt.executeQuery(strSQL);
	//获取记录总数
	sqlRst.last();
	intRowCount=sqlRst.getRow();
	//记算总页数
	intPageCount=(intRowCount+intPageSize-1)/intPageSize;
	//调整待显示的页码
	if(intPage>intPageCount)intPage=intPageCount;
%>
<!DOCTYPE HTML>
<html>
<head>
<title>我的病人</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="keywords" content="Petsy Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>

<link href="css/searchPatient.css" rel="stylesheet" type="text/css">
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
<!-- Custom Theme files -->
<link href="css/style.css" rel='stylesheet' type='text/css' />	
<script src="js/jquery.min.js"> </script>
<script src="js/bootstrap.min.js"></script>
<script src="js/birthday.js"> </script>

<script type="text/javascript" src="js/move-top.js"></script>
<script type="text/javascript" src="js/easing.js"></script>
<!--/script-->

<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event){		
					event.preventDefault();
					$('html,body').animate({scrollTop:$(this.hash).offset().top},900);
				});
			});
			//随访日期
			$(function () {
				$.ms_DatePicker({
			            YearSelector: ".sel_year",
			            MonthSelector: ".sel_month",
			            DaySelector: ".sel_day"
			    });
				$.ms_DatePicker();
			}); 
</script>

</head>
<body>
	<!--start-header-->
			<div id="home" style="margin-top:-20px" class="header two">
					<div class="top-header">
						<div class="container">
							<div class="logo">
							  <a href="doctorIndex.jsp"><h2>北京大学<span>第一医院</span></h2></a>
						    </div>
					     <div class="top-menu">
							<span class="menu"> </span>
								<ul class="cl-effect-16">
								<li><a href="doctorIndex.jsp" data-hover="主页">主页</a></li>
								<li><a  href="doctorAbout.jsp" data-hover="关于">关于</a></li>
								<li><a href="doctorHelper.jsp" data-hover="门诊助手">门诊助手</a></li>
								<li><a class="active" href="doctorPatient.jsp" data-hover="我的病人">我的病人</a></li>
								<li><a href="doctorAppoint.jsp" data-hover="日程管理">日程管理</a></li>
								<li><a href="doctorSetting.jsp" data-hover="设置">设置</a></li>
								<li style="color: white">|</li>
								<li><span class="glyphicon glyphicon-qrcode"  data-toggle="modal" data-target="#scanQRcode" data-backdrop="static" style="cursor: pointer;color: white"></span></li>
								<li class="dropdown" style="text-align: left;">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="glyphicon glyphicon-user"></span></a>
									<ul class="dropdown-menu" role="menu" id="doctor-contents">
										<li><a href="doctorProfile.jsp"><span class="glyphicon glyphicon-cog"></span> 修改资料</a></li>
										<li><a href="login.jsp"><span class="glyphicon glyphicon-log-out"></span> 退出</a></li>
									</ul>
			  					</li>		
								  <div class="clearfix"></div>
								</ul>
							</div>
							<!-- script-for-menu -->
								<script>
									$("span.menu").click(function(){
										$(".top-menu ul").slideToggle("slow" , function(){
										});
									});
								</script>
								<!-- script-for-menu -->
							<div class="clearfix"> </div>
					</div>
				</div>
	     </div>
     </div>
		<!--start-about-->
	
	<div class="about second">
		<div class="container" style="margin-top:-40px">
		 <h3 class="tittle wel" style="font-size: 1.9em">我的病人</h3>
		 <form method="post" action="patientQuery.jsp" id ="patientQuery">
		 <div class="selectbox" style="height:50px">
		 <div class="selemediv"> <div class="selemenu" id="patientGroup"><span style="font-weight: bold;">请选择组别</span></div>
			<DIV class="citylist group">
											<%
												//变量声明
												java.sql.Connection sqlConG; //数据库连接对象
												java.sql.Statement sqlStmtG; //SQL语句对象
												java.sql.ResultSet sqlRstG; //结果集对象
												java.lang.String strConG;//数据库连接字符串
												java.lang.String strSQLG;//SQL语句
												//装载JDBC驱动程序
												Class.forName("com.mysql.jdbc.Driver").newInstance();
												//设置数据库连接字符串
												strConG="jdbc:mysql://101.201.40.158:3306/ehealth";
												//连接数据库
												sqlConG=java.sql.DriverManager.getConnection(strConG,"root","123456");
												//创建一个可以滚动的只读的SQL语句对象
												sqlStmtG=sqlConG.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_READ_ONLY);
												//准备SQL语句
												strSQLG="select *from patient_divide";
												//执行SQL语句并获取结果集
												sqlRstG=sqlStmtG.executeQuery(strSQLG);
												//获取记录总数
												sqlRstG.last();
												%>
											<%
										        sqlRstG.absolute(1);
												while(!sqlRstG.isAfterLast()){
											 %>
				<span><%=sqlRstG.getString(2)%></span>
                                             <%
											 sqlRstG.next();			
											 }
											%>
			<!--<span>卵巢组</span>
				<span>更年组</span>
				<span>乳腺组</span>-->	
			</div>
		</div>
		<div class="selemediv">
			<div class="selemenu " >
				<span class="sqinput" style="font-weight: bold;">请选择类型</span><span class="csinput"></span></div>
			<DIV class="citylist classification">
				<span>首诊</span>
				<span>复诊</span>
				<span>一日门诊</span>
			</div>

		</div>
		<div class="selemediv"> <div class="selemenu"><span style="font-weight: bold;">请选择时间</span></div>
			<DIV class="citylist time">
				<span>今天</span>
				<span>一星期以内</span>
				<span>一个月以内</span>
				<span>半年以内</span>
			</div>
		</div>
		<div class="selemediv"> <div class="selemenu"><span style="font-weight: bold;">请选择血糖范围</span></div>
			<DIV class="citylist sugar"> 
				<span>小于50</span>
				<span>50-70</span>
				<span>70-90</span>
				<span>大于90</span>
			</div>
		</div>
		<div class="selemediv"> <div class="selemenu"><span style="font-weight: bold;">请选择血脂范围</span></div>
			<DIV class="citylist fat">
				<span>小于50</span>
				<span>50-70</span>
				<span>70-90</span>
				<span>大于90</span>
			</div>
		</div>
		<div class="selemediv"> <div class="selemenu"><span style="font-weight: bold;">请选择BMI范围</span></div>
			<DIV class="citylist bmi">
				<span>小于18.5</span>
				<span>18.5-25</span>
				<span>25-30</span>
				<span>大于30</span>
			</div>
		</div>
		<div class="pull-right send" style="padding-top: 1%">
		<input type="submit" value="查询" >
		</div>
	</div>
	<input id="group" type='hidden' name="group" value="">
	<input id="fatrange" type='hidden' name="fatrange" value="">
	<input id="sugarrange" type='hidden' name="sugarrange" value="">
	<input id="bmirange" type='hidden' name="bmirange" value="">
	<input id="classification" type='hidden' name="classification" value="">
	<input id="time" type='hidden' name="time" value="">
    </form>
		<div class="about-top">
				<table class="table table-striped table-hover " style="border: 1px solid #ddd; margin-top: 2%">
            			<thead>
	                <tr>
	                  <th>序号</th>
	                  <th>姓名</th>
	                  <th>类型</th>
					  <th>创建时间</th>
	                  <th>血糖mmol/l</th>
	                  <th>血脂mmol/l</th>
					  <th>BMI</th>
					  <th>腰臀比</th>
					  <th>组别</th>
					  <th>药品名称</th>
	                  <th>操作</th>
	                </tr>
	              </thead>
	              <tbody>
		             <%
						if(intPageCount>0){
						//将记录指针定位到待显示页的第一条记录上
						sqlRst.absolute((intPage-1)*intPageSize+1);
						//显示数据
						i=0;
						while(i<intPageSize&&!sqlRst.isAfterLast()){
					 %>
						<tr>
						<td><%=i+(intPage-1)*intPageSize+1%></td>
						<td><%=sqlRst.getString(2)%></td>
						<td><%=sqlRst.getString(3)%></td>
						<td><%=sqlRst.getString(4)%></td>
						<td><%=sqlRst.getString(5)%></td>
						<td><%=sqlRst.getString(6)%></td>
						<td><%=sqlRst.getString(7)%></td>
						<td><%=sqlRst.getString(8)%></td>
						<td><%=sqlRst.getString(9)%></td>
						<td><%=sqlRst.getString(10)%></td>
						<td>
			                  <a href="doctorPatientEach.jsp?name=<%=sqlRst.getString(2)%>&divide=<%=sqlRst.getString(9)%>&tell=<%=sqlRst.getString(11)%>">
			                   <form style="display:inline" action="doctorPatientEach.jsp" method="post"><input name="tell" style="display:none" value="<%=sqlRst.getString(11)%>">
			                     <input style="display:none" type="submit"><i class="glyphicon glyphicon-search templatemo-social-icon" title="查看" ></i>
			                   </form>
			                  </a>
			                  <i class="glyphicon glyphicon-pencil templatemo-social-icon" title="维护诊疗计划" data-toggle="modal" data-target="#<%=sqlRst.getString(2)%>" data-backdrop="static" ></i>
			                  <i class="glyphicon glyphicon-th-list templatemo-social-icon" title="分组" data-toggle="modal" data-target="#<%=sqlRst.getString(1)%>" data-backdrop="static" ></i>
			             <!--      <i class="glyphicon glyphicon-share-alt templatemo-social-icon" title="导出" data-toggle="modal" data-target="#" data-backdrop="static" ></i>  --> 
<!--******************************************病人分组 *****************************************************************-->	
<!--******************************************病人分组 *****************************************************************-->					                     
			                    <div id="<%=sqlRst.getString(1)%>" class="modal fade" >
									  <div class="modal-dialog" style="margin-top: 10%;width:450px;height: 100%">
							            <div class="modal-content">
							            <form  method="post" action="doctorPatientGroupAdd.jsp">
						                <input name="groupid" style="display:none" value="<%=sqlRst.getString(1)%>"  >
						                 <input name="intpage" style="display:none" value="<%=intPage%>"  >						                	
							                <div class="modal-header">
							                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							                    <h4 class="modal-title">病人分组</h4>
							                </div>
											<%
												//变量声明
												java.sql.Connection sqlCon1; //数据库连接对象
												java.sql.Statement sqlStmt1; //SQL语句对象
												java.sql.ResultSet sqlRst1; //结果集对象
												java.lang.String strCon1;//数据库连接字符串
												java.lang.String strSQL1;//SQL语句
												//装载JDBC驱动程序
												Class.forName("com.mysql.jdbc.Driver").newInstance();
												//设置数据库连接字符串
												strCon1="jdbc:mysql://101.201.40.158:3306/ehealth";
												//连接数据库
												sqlCon1=java.sql.DriverManager.getConnection(strCon1,"root","123456");
												//创建一个可以滚动的只读的SQL语句对象
												sqlStmt1=sqlCon1.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_READ_ONLY);
												//准备SQL语句
												strSQL1="select *from patient_divide";
												//执行SQL语句并获取结果集
												sqlRst1=sqlStmt1.executeQuery(strSQL1);
												//获取记录总数
												sqlRst1.last();
												%>
							                <div class="modal-body contact-grid" style="padding-left: 5%;width:450px;"> 
											<%
										        sqlRst1.absolute(1);
												while(!sqlRst1.isAfterLast()){
											 %>
												<div>
												<input type="checkbox" name="radio" id="r5" value="<%=sqlRst1.getString(2)%>">
												<label style="color: #888;"><%=sqlRst1.getString(2)%></label>   
												</div>

						           			<%
											 sqlRst1.next();			
											 }
											%>
							                </div>

							                <div class="modal-footer">
							                    <button type="submit" class="btn btn-success" style="background-color: #20CBBE; border-color: #20CBBE">保存</button>
							                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							                </div>
							             </form>
							             </div>
							        </div>
							    </div>


<!--******************************************维护诊疗计划*****************************************************************-->	
<!--******************************************维护诊疗计划*****************************************************************-->									    
		               <div id="<%=sqlRst.getString(2)%>" class="modal fade" >
								 <div class="modal-dialog" style="margin-top: 10%;width:600px;height: 100%">
						            <div class="modal-content">
						                <div class="modal-header">
						                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						                    <h4 class="modal-title">维护诊疗计划</h4>
						                </div>
						                 <form  method="post" action="doctorPatientMedicineAddShortcut.jsp">	
							                <div class="modal-body contact-grid" style="height:500px;">								               				                	
							                	<input name="medicinetime" style="display:none" value="<%=sqlRst.getString(4)%>">
							                	<input name="medicinetel" style="display:none" value="<%=sqlRst.getString(11)%>">							                
												<input name="intpage" style="display:none" value="<%=intPage%>">	
													<div class="col-md-12">
													<p class="col-md-3 your-para" >选择用药</p>
														<div class="col-md-9">
															<select name="YYYY" >
							    							<option value="药品名称" selected = "selected">药品名称</option>
							    							<option value="益母草颗粒">益母草颗粒</option>
							    							<option value="感冒胶囊">感冒胶囊</option>
							    							<option value="延更丹">延更丹</option>
							  							</select>
							  							<select name="MM" >
							    							<option value="药品用量" selected = "selected">药品用量</option>
							    							<option value="一次1粒">一次1粒</option>
							    							<option value="一次2粒">一次2粒</option>
							    							<option value="一次3粒">一次3粒</option>
							  							</select>
							 							<select name="DD">
							 								<option value="用药频率" selected = "selected">用药频率</option>
							    							<option value="一日一次">一日一次</option>
							    							<option value="一日两次">一日两次</option>
							    							<option value="一日三次">一日三次</option>
							  							</select>
														</div>			
													</div>	
													<div class="col-md-12">
													<p class="col-md-3 your-para"  style="padding-top: 2%">用药列表</p>
														<div class="col-md-9" style="padding-top: 2%">
															<select name="commonlist" >
							    							<option value="药品名称" selected = "selected">常用药列表</option>
							    							<option value="1莉芙敏1片Bid">1莉芙敏1片Bid</option>
							    							<option value="2莉芙敏+利维爱0.5片Qod">2莉芙敏+利维爱0.5片Qod</option>
							    							<option value="3莉芙敏+利维爱0.5片Qd">3莉芙敏+利维爱0.5片Qd</option>
							    							<option value="4莉芙敏+利维爱1片Qd">4莉芙敏+利维爱1片Qd</option>
							    							<option value="5利维爱A0.5Qod  B0.5Qd  C 1片Qd">5利维爱A0.5Qod  B0.5Qd  C 1片Qd</option>
							    							<option value="6补佳乐+地屈0.5片Qd">6补佳乐+地屈0.5片Qd</option>
							    							<option value="7补佳乐+地屈1片Qd，B补佳乐0.5Qd+地屈1片Qd">7补佳乐+地屈1片Qd，B补佳乐0.5Qd+地屈1片Qd</option>
							    							<option value="8芬吗通2/10 Qd PO ">8芬吗通2/10 Qd PO </option>
							    							<option value="9克龄蒙 1#Q">9克龄蒙 1#Q</option>
							  							    </select>
														</div>			
													</div>	
										            <div class="col-md-12" >
														<p class="col-md-3 your-para" style="padding-top: 2%">随访模板</p>
														<div class="col-md-9" style="padding-top: 2%" >
														<!--  <textarea name="demand"></textarea> -->
                                                        <p><div style="width:238px"><input type="checkbox" name="sfmodel" value="1" />肝、肾功能、血脂 
                                                           <div style="float:right"><input type="checkbox" name="sfmodel" value="2" />激素</div>
                                                           </div></p>   
													 
													      
													    <p><div style="width:270px"><input type="checkbox" name="sfmodel" value="3"/>血Ca、尿Ca、VitD
													       <div style="float:right"><input type="checkbox" name="sfmodel" value="4"/>甲功五项</div>
													       </div></p>    
													    <p><div style="width:264px"><input type="checkbox" name="sfmodel" value="5" />阴道彩超
													       <div style="float:right"><input type="checkbox" name="sfmodel" value="6" />乳腺B超</div>
													       </div>
													       </p>    
													      
													    <p><div style="width:280px"><input type="checkbox" name="sfmodel" value="7" />甲状腺B超
													       <div style="float:right"><input type="checkbox" name="sfmodel" value="8" />颈功腺B超</div>
													       </div>
													       </p>  
													   
													    <p><div  style="width:302px"><input type="checkbox" name="sfmodel" value="9"/>双无能X线
													       <div style="float:right"><input type="checkbox" name="sfmodel" value="0" />人体成分分析</div>
													       </div>
													       </p> 
													  
														</div>
													</div>			
													
													<div class="col-md-12">
													<p class="col-md-3 your-para" style="padding-top: 2%">下次随访时间</p>
													<div class="col-md-9" style="padding-top: 2%" >
											        <select class="sel_year" name="sel_year"></select>年
											        <select class="sel_month" name="sel_month"></select>月
											        <select class="sel_day" name="sel_day"></select>日
												    </div>	
												    
													<div class="col-md-12">
															<p class="col-md-3 your-para" style="padding-top: 2%" >备注</p>
															<div class="col-md-9" style="padding-top: 2%" >
															<textarea name="remark" ></textarea>
															</div>
												    </div>
												    

																	
							                </div>
							                <div style="text-align:right;" >
							                    <button type="submit" class="btn btn-success"  style="background-color: #20CBBE; border-color: #20CBBE">保存</button>
							                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
							                </div>
										</form>
						             </div>
						        </div>
						    </div>
  
		                </td>
						</tr>								       
					<%
					 sqlRst.next();
					 i++;
					 }
					}
					%>		
                   </tbody>
                   </table>
				<div class="page_nation" style="text-align: center;">
				<nav>
					 第<%=intPage%>页 共<%=intPageCount%>页  
					<%if(intPage<intPageCount){%>
					<a href="doctorPatient.jsp?page=<%=intPage+1%>">下一页</a><%}else if(intPage==intPageCount) {%><a href="#">下一页</a><%}%>
					<%if(intPage>1){%>
					<a href="doctorPatient.jsp?page=<%=intPage-1%>">上一页</a><%}else {%><a href="#">上一页</a><%}%>
				  </nav>		
				</div>
			<div class="clearfix"></div>
		</div>
	</div>	 
	</div>
	  
  <!--footer-->
			<div class="footer text-center" style="padding-bottom: 0; text-align: center;">
				<div class="container">
					<div class="copy">
		              <p style="color: black">Copyright &copy; 2016. School of Electronics Engineering and Computer Science, Peking University.</p>
		            </div>
				</div>
			</div>

				<!--start-smoth-scrolling-->
						<script type="text/javascript">
									$(document).ready(function() {	
										$().UItoTop({ easingType: 'easeOutQuart' });
										
									});
								</script>
		<a href="#home" id="toTop" class="scroll" style="display: block;"> <span id="toTopHover" style="opacity: 1;"> </span></a>

		<div id="scanQRcode" class="modal fade" >
		<div class="modal-dialog" style="margin-top: 10%;width:400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">E-Health</h4>
                </div>
                <div class="modal-body">
                	<p>我是一个二维码</p>
                	<p>扫描二维码，关注E-Health微信公众号。</p>
                </div>
                
                <div class="modal-footer">
                <!--
                    <button type="button" class="btn btn-success" onclick="deleteNSgroup()">确定</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    -->
                </div>

             </div>
        </div>
    </div>
    <script type="text/javascript">
     $(document).ready(function() {
    	  $('input[type=checkbox]').click(function() {
    	   $("input[name='radio']").attr('disabled', true);
    	   if ($("input[name='radio']:checked").length >= 1) {
    	    $("input[name='radio']:checked").attr('disabled', false);
    	   } else {
    	    $("input[name='radio']").attr('disabled', false);
    	   }
    	  });
    	 })       
    </script> 
	<script>
		$(".selemenu").click(function(){
			$(this).next().slideToggle();
			$(this).parents().siblings().find(".citylist,.citylist2").slideUp();
		})
		$(".citylist span").click(function(){
			var text=$(this).text();
			$(this).parent().prev().html(text);
			$(this).parent().prev().css("color","#666")
			$(this).parent().fadeOut();
			//$("#fatrange").val(text);
		})
		$(".fat span").click(function(){
			var text=$(this).text();
			$("#fatrange").val(text);
		})
		$(".sugar span").click(function(){
			var text=$(this).text();
			$("#sugarrange").val(text);
		})
		$(".group span").click(function(){
			var text=$(this).text();
			$("#group").val(text);
		})
		$(".bmi span").click(function(){
			var text=$(this).text();
			$("#bmirange").val(text);
		})
		$(".classification span").click(function(){
			var text=$(this).text();
			$("#classification").val(text);
		})
		$(".time span").click(function(){
			var text=$(this).text();
			$("#time").val(text);
		})
		$(".shangquan li").click(function(){
			$(".shangquan li").removeClass("active")
			$(this).addClass("active")
			var text1=$(this).text();
			$(".sqinput").html(text1)
		})
		$(".chengshi li").click(function(){
			$(".chengshi li").removeClass("active")
			$(this).addClass("active")
			var text2=$(this).text();
			$(".csinput").html("-"+text2)
			$(".citylist2").slideUp();
		})
		$(function(){
			$(document).not($(".selectbox")).click(function(){
				$(".citylist,.citylist2").slideUp();
			})
			$(".selectbox").click(function(event){
				event.stopPropagation();
			})
		})
	</script>
	
</body>
</html>
<%
//关闭结果集
sqlRst.close();
//关闭SQL语句对象
sqlStmt.close();
//关闭数据库
sqlCon.close();
%> 