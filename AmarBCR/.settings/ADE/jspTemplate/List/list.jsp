<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/Frame/resources/include/include_begin_list.jspf"%><%	
	/*
        Author: #{author} #{createddate}
        Content: 
        History Log: 
    */
	ASObjectModel doTemp = new ASObjectModel("#{dono}");
	ASObjectWindow dwTemp = new ASObjectWindow(CurPage,doTemp,request);
	dwTemp.Style="1";      	     //--设置为Grid风格--
	//dwTemp.MultiSelect = true;	 //多选/**修改模板时请不要修改这一行*/
	//dwTemp.ShowSummary="1";	 	 //汇总/**修改模板时请不要修改这一行*/
	dwTemp.ReadOnly = "1";	 //只读模式
	dwTemp.setPageSize(10);
	dwTemp.genHTMLObjectWindow("");

	//0、是否展示 1、	权限控制  2、 展示类型 3、按钮显示名称 4、按钮解释文字 5、按钮触发事件代码	6、	7、	8、	9、图标，CSS层叠样式 10、风格
	String sButtons[][] = {
		{"true","All","Button","新增","新增","newRecord()","","","","btn_icon_add",""},
		{"true","","Button","详情","详情","viewAndEdit()","","","","btn_icon_detail",""},
		{"true","","Button","删除","删除","if(confirm('确实要删除吗?'))as_delete(0,'alert(getRowCount(0))')","","","","btn_icon_delete",""},
	};
%><%@include file="/Frame/resources/include/ui/include_list.jspf"%>
<script type="text/javascript">
	function newRecord(){
		 var sUrl = "";
		 AsControl.OpenView(sUrl,'','_self','');
	}
	function viewAndEdit(){
		 var sUrl = "";
		 var sPara = getItemValue(0,getRow(0),'SerialNo');
		 if(typeof(sPara)=="undefined" || sPara.length==0 ){
			alert("参数不能为空！");
			return ;
		 }
		AsControl.OpenView(sUrl,'SerialNo=' +sPara ,'_self','');
	}
</script>
<%@ include file="/Frame/resources/include/include_end.jspf"%>