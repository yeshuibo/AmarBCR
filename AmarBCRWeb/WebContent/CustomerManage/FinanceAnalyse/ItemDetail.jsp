<%@ page contentType="text/html; charset=GBK"%>
<%@ include file="/IncludeBeginMD.jsp"%>
<%@page import="com.amarsoft.biz.finance.*" %><%
	/*
		Content: --ָ�����
		Input Param:
		                 --CustomerID���ͻ���
		                 --ReportCount ����������
		                 --EntityCount ���ͻ���
	 */
   //�������
    String sAccountMonths = "";//--�������� 
    String sScopes = "" ;  //--������Χ
    String sMonthsScopes = "";//�������¼ӿھ�
   	String sFinanceBelong = "";//--��������
	double dTemp;//--�����������
	double dTempIndustry ;//--�����ҵ����
    String sTemp="";//--��ŵ��ַ�������
    String sTempsIndustry="";//--��ŵ��ַ�����ҵ����
    String sTrueFlag="FALSE" ;//--��־�ж�
	String sReportName = "";//--��������
	String sCustomerName = "";//--�ͻ�����
	String sSql="";//--���sql���
	
   //���ҳ����������������ͻ������ͻ�����
	String sReportCount = CurPage.getParameter("ReportCount");
	String sEntityCount = CurPage.getParameter("EntityCount");
	String sCustomerID  = CurPage.getParameter("CustomerID");
	
	ASResultSet rsTemp = Sqlca.getASResultSet("select FinanceBelong from ENT_INFO where CustomerID= '" + sCustomerID + "'");
	if(rsTemp.next()) sFinanceBelong = rsTemp.getString(1);		
	rsTemp.getStatement().close();
	
	String sReportNo = sFinanceBelong + "9";
	sSql = "select ReportName from FINANCE_CATALOG where ReportNo = '" + sReportNo + "'";
	rsTemp = Sqlca.getResultSet(sSql);
	if(rsTemp.next())
		sReportName = rsTemp.getString("ReportName");
	rsTemp.getStatement().close();
	
	sSql = "select CustomerName from CUSTOMER_INFO where CustomerID = '" + sCustomerID + "'";
	rsTemp = Sqlca.getResultSet(sSql);
	if(rsTemp.next())
		sCustomerName = rsTemp.getString(1);
	rsTemp.getStatement().close();
	
	int iSubTitleSpan = 0, iTitleSpan = 0;
	iSubTitleSpan = Integer.parseInt(sEntityCount) + 1;
	iTitleSpan = iSubTitleSpan * Integer.parseInt(sReportCount) + 1;
	
	String sTempNumber="";

	//ʱ������(����
	//���贫������˳�����еģ�CurPage:AccountMonth1=2001/12,AccountMonth2=2002/12,AccountMonth3=2003/12
	//�����ݽ�������ʾ���ǵ���,��ǰһ��(2003/12)��ǰ����(2002/12)��ǰ����(2001/12)
	//��ͼ�ν�������ʾ����˳�򣬼�2001/12,2002/12,2003/12
	//aMonth�ŵ��ǵ���,�������ݽ���, 2003/12 2002/21 2001/12
	String aMonth[]=null,aScope[]=null;
	aMonth = new String[Integer.parseInt(sReportCount)+1];
	aScope = new String[Integer.parseInt(sReportCount)+1];
	for(int i=Integer.parseInt(sReportCount); i>=1; i--){
		aMonth[Integer.parseInt(sReportCount)-i+1] = CurPage.getParameter("AccountMonth" + i);
		aScope[Integer.parseInt(sReportCount)-i+1] = CurPage.getParameter("Scope" + i);
	}
	//��һ������"2"��ʾָ���������ReportAnalyse�ύָ�������Ч��
	ReportAnalyse reportAnalyse = new ReportAnalyse("2",sCustomerID,sReportNo,sReportCount,aMonth,aScope,Sqlca);//@jlwu
%>
<head>
	<title>ָ�����</title>
</head>
<body class="ReportPage" leftmargin="0" topmargin="0" onload="" style="overflow:auto" oncontextmenu="return false">
<form name="form0">
<table border="0" width="100%" height="100%" cellspacing="0" cellpadding="0" >
	<tr height=1 valign=top id="buttonback" >
		<td>
			<table style="width: 100%">
			<tr>
				<td>
					<%=new Button("��&nbsp;��","�رմ���","confirm('�رյ�ǰ���ڣ�')?top.close():''","","").getHtmlText()%>
				</td>
				<td>
					<%=new Button("ת�������ӱ���","ת�������ӱ���","excelShow()","","").getHtmlText()%>
				</td>
				<td align=left>
					ѡȡͼ��չ�ַ�ʽ��
					<select id="GraphType">
						<option value=0 >��״ͼ</option>
						<option value=6 >����ͼ</option>
					</select>
				</td>
				<td align=left>
					<%=new Button("ͼ��չ��","ͼ��չ��","graphShow()","","").getHtmlText()%>
				</td>
			</tr>
			</table>
		</td>
	</tr>
	<tr valign="top" >
		<td style='BORDER-bottom: #000000 1px solid;' >
		<div id="reporttable">
			<script type="text/javascript">
				var aValues = new Array();
				var aNames = new Array();
			</script>
			<table border=1 cellpadding=0 cellspacing=0 width="100%" align="center" bgcolor="#F0F0F0">
			<%
				String sTempValues = "",sTempNames = "";
				String sTempValue = "";
				//��ͷ
				String sAccountMonth = "", sScope = "", sUnit = "";
				sAccountMonth = CurPage.getParameter("AccountMonth1");
				sScope = CurPage.getParameter("Scope1");
				//FinanceAnalyse financeReport = new FinanceAnalyse(0, sCustomerID, sAccountMonth, sReportNo, sScope, Sqlca);@jlwu
				//sUnit = financeReport.FinanceUnit;@jlwu
			%>
				<tr>
					<td colspan="<%=iTitleSpan%>" align="center"><%=sReportName + "����ָ�����"%></td>
				</tr>
				<tr>
					<td colspan="<%=Math.floor(iTitleSpan/2)%>" align="left"><%="�ͻ����ƣ�" + sCustomerName%></td>
					<td colspan="<%=iTitleSpan - Math.floor(iTitleSpan/2)%>" align="right"><%="��λ�������Ԫ"%> </td>
				</tr>
				<tr>
					<td rowspan="2" align="center" valign="center" nowrap>ָ������</td>
			<%
				for(int i=Integer.parseInt(sReportCount); i>=1; i--){
					//sAccountMonth = CurPage.getParameter("AccountMonth" + i);
					//sScope = CurPage.getParameter("Scope" + i);
					sAccountMonth = aMonth[Integer.parseInt(sReportCount)-i+1];
					sScope = aScope[Integer.parseInt(sReportCount)-i+1];

					if(i!=1) sAccountMonths = sAccountMonths + sAccountMonth + "@";
					else     sAccountMonths = sAccountMonths + sAccountMonth ;
					
					if(i!=1) sScopes = sScopes + sScope + "@";
					else     sScopes = sScopes + sScope ;
					
					//�·ݼӿھ����������ڶ�ھ���չ	
					if(i!=1) sMonthsScopes = sMonthsScopes + sAccountMonth+" "+((sScope.equals("01"))?"�ϲ�":(sScope.equals("02")?"����":"����"))+"@";
					else 	sMonthsScopes = sMonthsScopes + sAccountMonth+" "+((sScope.equals("01"))?"�ϲ�":(sScope.equals("02")?"����":"����"));
			%>
					<td colspan="<%=iSubTitleSpan%>" align="center">
						<%=StringFunction.getSeparate(sAccountMonth,"/",1) + "��" + StringFunction.getSeparate(sAccountMonth,"/",2) + "��  "+((sScope.equals("01"))?"�ϲ�":(sScope.equals("02")?"����":"����"))%>
					</td>
			<%
				}
			%>
				</tr>
				<tr>
			<%
				String sEntityType = "", sEntityID = "", sEntityName = "";
				for(int i=1; i<=Integer.parseInt(sReportCount); i++){
			%>
					<td align="center" nowrap>ָ��ֵ</td>
			<%
					for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
						sEntityType = CurPage.getParameter("EntityType" + j);
						sEntityID = CurPage.getParameter("EntityID" + j);
						if(sEntityType.equals("Industry"))
							sSql = "select getIndustryName('" + sEntityID + "') from dual";
						else
							sSql = "select CustomerName from CUSTOMER_INFO where CustomerID = '" + sEntityID + "'";
						rsTemp = Sqlca.getResultSet(sSql);
						if(rsTemp.next())
							sEntityName = rsTemp.getString(1);
						rsTemp.getStatement().close();
			%>
						<td align="center"><%=sEntityName%></td>
			<%
					}
				}
				
				//����
				String sFinanceItemNo = "", sDisplayName = "", sFormatType = "";
				sAccountMonth = CurPage.getParameter("AccountMonth" + sReportCount);
				sScope = CurPage.getParameter("Scope" + sReportCount);
//��ʱδ���� DisplayAttribute	//"1":������,"2":�ٷֱ�,"3":������			
//				rsTemp = Sqlca.getResultSet("select FD.FinanceItemNo,FD.DisplayName,FM.DisplayAttribute from FINANCE_MODEL FM,FINANCE_DATA FD where FM.ReportNo = FD.ReportNo and FM.DisplayNo = FD.DisplayNo and FD.CustomerID = '" + sCustomerID + "' and FD.AccountMonth = '" + sAccountMonth + "' and FD.ReportNo = '" + sReportNo + "' and FD.Scope = '" + sScope + "' and (FM.DeleteFlag <> '1' or FM.DeleteFlag is null) order by FD.DisplayNo");
				rsTemp = Sqlca.getResultSet("select FD.FinanceItemNo,FD.DisplayName from FINANCE_DATA FD where  FD.CustomerID = '" + sCustomerID + "' and FD.AccountMonth = '" + sAccountMonth + "' and FD.ModelNo = '" + sReportNo + "' and FD.Scope = '" + sScope + "'  order by FD.DisplayNo");

				int icount=0;
				while(rsTemp.next()){
					icount++;
					sFinanceItemNo = DataConvert.toString(rsTemp.getString(1));
					sDisplayName = DataConvert.toString(rsTemp.getString(2));
					sTempNames = sDisplayName+"@";
					
					//sFormatType = DataConvert.toString(rsTemp.getString(3));
					//if(sFormatType == null || sFormatType.equals(""))
						sFormatType = "2";
					
				if(sDisplayName.length() > 0){
  				    sTempValues = "";					
					sDisplayName  = StringFunction.replace(sDisplayName," ","&nbsp;");
				if(sFinanceItemNo == null || sFinanceItemNo.equals("")){
			%>
				<tr  bgcolor=<%=(icount%2==0)?"#F6F5FA":"#EDEBF6"%>>
					<td colspan="<%=iTitleSpan%>" align="left" nowrap><%=sDisplayName%></td>
				</tr>
			<%
				}else{
			%>
				<tr  bgcolor=<%=(icount%2==0)?"#F6F5FA":"#EDEBF6"%>>					
					<td align="left" nowrap>
						<input type=checkbox name ="checkbox<%=icount%>"  value=<%=sFinanceItemNo%> >
						<%=sDisplayName%>
					</td>
			<%
					for(int i=Integer.parseInt(sReportCount); i>=1; i--){
						sTemp="";
						sTempsIndustry="";
						sTrueFlag="FALSE" ;
						sAccountMonth = aMonth[Integer.parseInt(sReportCount)-i+1];
						sScope = CurPage.getParameter("Scope" + i);
						//sTemp = FinanceAnalyse.getItemValue(0,sCustomerID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca);
                     sTemp = reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ParaValue.getAttribute(sFinanceItemNo).toString();//@jlwu
                     if(sTemp!=null&&!sTemp.equals("")){ 
							dTemp=Double.parseDouble(sTemp);
						}else{
                          dTemp=Double.parseDouble("0");
                        }
						
                     if (i==Integer.parseInt(sReportCount)){
							for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
								sEntityType = CurPage.getParameter("EntityType" + j);
								sEntityID = CurPage.getParameter("EntityID" + j);
								if(sEntityType.equals("Industry")){
								   sTempsIndustry = ReportAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca);
								}
								if(sTempsIndustry!=null&&!sTempsIndustry.equals("")){
									dTempIndustry=Double.parseDouble(sTempsIndustry);
									if (dTempIndustry!=0){
										if(((dTemp-dTempIndustry)/dTempIndustry)>0.3||((dTemp-dTempIndustry)/dTempIndustry)<-0.3){
										   sTrueFlag="TRUE";
										   continue;
										}
									}
								}
							}
						}
						sTempValue = ReportAnalyse.convertByUnit(reportAnalyse.reportData[Integer.parseInt(sReportCount)-i].ParaValue.getAttribute(sFinanceItemNo).toString(),"01");
						//"1":������,"2":�ٷֱ�,"3":������
						sTempNumber = ReportAnalyse.applyFormat(sTempValue,sFormatType);
						if(sTempNumber!=null&&!sTempNumber.equals("")){
							if(sFormatType.equals("3"))
								sTempValues = sTempValues + StringFunction.replace(FinanceAnalyse.formatNumber(Double.parseDouble(sTempValue)),",","") + "@";				
							else if(sFormatType.equals("2"))
								sTempValues = sTempValues + StringFunction.replace(FinanceAnalyse.formatNumber(Double.parseDouble(sTempValue)*100),",","") + "@";				
							else
								sTempValues = sTempValues + StringFunction.replace(FinanceAnalyse.formatNumber(Double.parseDouble(sTempValue)/10000),",","") + "@";				
						}else
							sTempValues = sTempValues + "@";
												
						//sTempNumber.equals("0.00%")?"":sTempNumber.equals("0.00%")?"":sTempNumber												
			%>
						<td align="right" nowrap>
							<font color=<%=(sTrueFlag.equals("TRUE"))?"red":"black"%>> &nbsp;<%=sTempNumber%>
						</td>
			<%
						for(int j=1; j<=Integer.parseInt(sEntityCount); j++){
							sEntityType = CurPage.getParameter("EntityType" + j);
							sEntityID = CurPage.getParameter("EntityID" + j);
							String sValue = "";
							if(sEntityType.equals("Industry")){
								sValue = ReportAnalyse.applyFormat(ReportAnalyse.convertByUnit(FinanceAnalyse.getItemValue(0,sEntityID, StringFunction.getSeparate(sAccountMonth,"/",1), "0001", "01", sFinanceItemNo, Sqlca),"01"),sFormatType);
							}else{
								sValue = ReportAnalyse.applyFormat(ReportAnalyse.convertByUnit(FinanceAnalyse.getItemValue(0,sEntityID, sAccountMonth, sReportNo, sScope, sFinanceItemNo, Sqlca),"01"),sFormatType);
							}
							
							//sValue.equals("0.00%")?"":sValue.equals("0.00")?"":sValue
			%>
							<td align="right" nowrap>
								&nbsp;<%=sValue%>
							</td>
			<%
						}
					}
			%>
				<script type="text/javascript">
					aValues[<%=icount%>] = "<%=sTempValues%>";
					aNames[<%=icount%>] = "<%=sTempNames%>";
				</script>
				</tr>
			<%
				}
				
				}
				
				}
				rsTemp.getStatement().close();
			%>
			</table>
		</div>
		</td>
	</tr>
</table>
</form>
</body>

<script>
/*~[Describe=����excel;InputParam=��;OutPutParam=��;]~*/
function excelShow(){
	var mystr = document.getElementById('reporttable').innerHTML;
	spreadsheetTransfer(mystr.replace(/type=checkbox/g,"type=hidden"));
}
/*~[Describe=����ͼ��;InputParam=��;OutPutParam=��;]~*/
function graphShow(){
	var sChecked = "",iChecked = 0,sItemNames="",sItemValues="";
	var cForms = document.forms["form0"];
	//ѭ��ȡ������ѡ�еĸ�ѡ�򣬷�������valueֵ��ɵķ��ش�
	for(var k=0;k<cForms.elements.length;k++){
		if (cForms.elements[k].checked){
			sChecked += cForms.elements[k].value+"@";
			sItemNames  += aNames[parseInt(cForms.elements[k].name.substr(8,cForms.elements[k].name.length-1),10)];
			sItemValues += aValues[parseInt(cForms.elements[k].name.substr(8,cForms.elements[k].name.length-1),10)];
			iChecked ++ ;
		}
	}
	
	if(iChecked==0){
		alert(getMessageText('ALS70174'));//����Ҫѡһ��ָ�����ͼ��չ�֣�
		return;
	}

	if(iChecked>6){
		alert(getMessageText('ALS70175'));//һ�ε�ѡ������6����Ŀ,��ȥ��һЩ��Ŀ�ٽ���ͼ��չ�֣�
		return;
	}

	sChecked = sChecked.substr(0,sChecked.length-1);
	sItemNames = sItemNames.substr(0,sItemNames.length-1);
	sItemValues = sItemValues.substr(0,sItemValues.length-1);
	sGraphType = document.getElementById("GraphType").value;
	sScreenWidth = screen.availWidth-40;
	sScreenHeight = screen.availHeight-40;
    PopPage("/CustomerManage/FinanceAnalyse/ShowGraph.jsp?GraphType="+sGraphType+"&MonthsScopes=<%=sMonthsScopes%>&ItemNames="+sItemNames+"&ItemValues="+sItemValues+"&ScreenWidth="+sScreenWidth+"&ScreenHeight="+sScreenHeight+"&rand="+randomNumber(),"_blank",sDefaultDialogStyle);
}
</script>
<%@ include file="/IncludeEnd.jsp"%>