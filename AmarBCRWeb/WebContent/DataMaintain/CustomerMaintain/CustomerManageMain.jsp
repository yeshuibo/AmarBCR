<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBegin.jsp"%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main00;Describe=注释区;]~*/%>
	<%
	/*
		Author: qhhui
		Tester:
		Content: 客户信息维护主页面
		Input Param:
		Output param:
		History Log: 

	 */
	%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main01;Describe=定义页面属性;]~*/%>
	<%
	String PG_TITLE = "客户信息维护"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;客户信息维护&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度
	%>
<%/*~END~*/%>

<%/*~BEGIN~可编辑区~[Editable=true;CodeAreaID=Main03;Describe=定义树图;]~*/%>
	<%
	//定义Treeview
	HTMLTreeView tviTemp = new HTMLTreeView(SqlcaRepository,CurComp,sServletURL,"客户信息维护","right");
	tviTemp.TriggerClickEvent=true; //是否选中时自动触发TreeViewOnClick()函数

	//定义树图结构
	tviTemp.insertPage("root","客户信息维护","",1);

	%>
<%/*~END~*/%>


<%/*~BEGIN~不可编辑区[Editable=false;CodeAreaID=Main04;Describe=主体页面;]~*/%>
	<%@include file="/Resources/CodeParts/Main04.jsp"%>
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main05;Describe=树图事件;]~*/%>
	<script type="text/javascript"> 
	
	/*~[Describe=treeview单击选中事件;InputParam=无;OutPutParam=无;]~*/

	function TreeViewOnClick()
	{
		//如果tviTemp.TriggerClickEvent=true，则在单击时，触发本函数

		var sCurItemname = getCurTVItem().name;
		
		if(sCurItemname=='客户信息维护'){
			OpenComp("CustomerManageList","/DataMaintain/CustomerMaintain/CustomerManageList.jsp","","right");
		}else{
			return;							
		}
		
		setTitle(getCurTVItem().name);
	}

	
	
	/*~[Describe=生成treeview;InputParam=无;OutPutParam=无;]~*/
	function startMenu() 
	{
		<%=tviTemp.generateHTMLTreeView()%>
	}
		
	</script> 
<%/*~END~*/%>


<%/*~BEGIN~可编辑区[Editable=true;CodeAreaID=Main06;Describe=在页面装载时执行,初始化;]~*/%>
	<script language="javascript">
	startMenu();
	expandNode('root');	
	selectItem("1");
	</script>
<%/*~END~*/%>
<%@ include file="/IncludeEnd.jsp"%>