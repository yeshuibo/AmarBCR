<%@ page contentType="text/html; charset=GBK"%><%@
 include file="/IncludeBegin.jsp"%><%
	String PG_TITLE = "组合页面配置"; // 浏览器窗口标题 <title> PG_TITLE </title>
	String PG_CONTENT_TITLE = "&nbsp;&nbsp;"+PG_TITLE+"&nbsp;&nbsp;"; //默认的内容区标题
	String PG_CONTNET_TEXT = "请点击左侧列表";//默认的内容区文字
	String PG_LEFT_WIDTH = "1";//默认的treeview宽度,不显示树图
%><%@include file="/Resources/CodeParts/Main04.jsp"%>
<script type="text/javascript">
	//myleft.width=1;
	AsControl.OpenView("/AppConfig/PageMode/GroupPage/GroupPageMainFrame.jsp","","right");
</script>
<%@ include file="/IncludeEnd.jsp"%>