<div class="myCreditor" id="myCreditor_tab2" style="display:none">
	<table class="table table-hover">
		<thead>
			<tr>
				<th style="width:20%;text-align: center;">借款标题</th>
				<!--<th>标的总额</th>  -->
				<th style="width:18%;text-align: center;">投资金额</th>
				<!--<th>剩余债权</th> -->
				<th style="width:15%;text-align: center;">收益金额</th>
				<th style="width:12%;text-align: center;">年利率</th>
				<th style="width:20%;text-align: center;">还款方式</th>
				<!--<th>期数</th> -->
				<!--<th>状态</th> -->
				<th style="width:15%;text-align: center;">结清日期</th>
			</tr>
		</thead>
		<tbody id="datas5">
		</tbody>
	</table>
  <div id="Pagination2" class="pagination pagination-right"></div>
</div>
<script type="text/javascript">
//<![CDATA[
	// 已结清的债权
	function ajaxQuery2(requestPage,isInit){
		$.ajax({
				type:"POST",
				url:"ajaxQueryCreditorRecovered.do",
				dataType:"json",
				data:"requestPage=" + requestPage + "&pageSize=" + itemPerPage,
				complete:function(XMLHttpRequest,textStatus) {
					if(XMLHttpRequest.status == 535){  
					      //如果超时就处理 ，指定要跳转的页面 
					      dialog({
								title:"提醒信息",
								content:"登陆超时，请重新登陆！",
								okvalue:"确定",
								ok:function(){
								 	window.location.replace("${base}/loginAction/login.do");
								 },
								 onclose:function(){
								  window.location.replace("${base}/loginAction/login.do");
								 }
							}).showModal(); 
					}
				},
				success:function(data) {
					$('tr[id^=ready]').remove();
			        $.each(data.list, function(i, n){
			        	var row = $("<tr></tr>");
			        	row.attr("id","ready"+i);//改变绑定好数据的行的id
			        	row.append($("<td style=\"width:20%;text-align: center;\" ><a target='_blank' href=\"${base}/loan/detail.do?loanApproveId="+n.loan_approve_id+"\" title=\""+n.loanName+"\">"+n.loan_name+"</td>"));
			        	//row.append($("<td style=\"width:18%;text-align: center;\" >"+n.loan_amt+"</td>"));
			        	row.append($("<td style=\"width:18%;text-align: center;\" >"+fmoney(n.cr_amt,2)+"</td>"));
			        	//row.append($("<td style=\"width:12%;text-align: center;\" >"+n.unretrieve_amt+"</td>"));
			        	row.append($("<td style=\"width:12%;text-align: center;\" >"+fmoney(n.tot_profit_amt,2)+"</td>"));
			        	row.append($("<td style=\"width:15%;text-align: center;\" >"+n.rate+"%</td>"));
			        	row.append($("<td style=\"width:20%;text-align: center;\" >"+n.repay_type_cd+"</td>"));
			        	//row.append($("<td style=\"width:12%;text-align: center;\" >"+n.term+"</td>"));
			        	//row.append($("<td style=\"width:20%;text-align: center;\" >"+n.cr_status_cd+"</td>"));
			        	row.append($("<td style=\"width:15%;text-align: center;\" >"+n.settle_date+"</td>"));
			        	row.appendTo("#datas5");
	                });// 分页
	                if(isInit){
	                	pageQuery2(data.totalCount);
	                }
					
	                $("#loading").hide();
	                $('tr[id^=ready]').show();
			         
				},
				error:function(text) {
					alert('请求后台出错.');
				} 
			});
		}
	
	
	// 分页查询
	function pageQuery2(dataSize){
	    var optInit = $.extend({
		items_per_page:itemPerPage,
		num_display_entries:10,
		current_page:0,
		num_edge_entries:2,
		prev_text:"上一页",
		next_text:"下一页",
		callback:pageselectCallback2
		});
	    $("#Pagination2").pagination(dataSize, optInit);
	}
	
	// 分页组件回调函数
	function pageselectCallback2(page_index, j){
        //ajaxQuery2(page_index+1,false);
        if(!isFistLoad2){
			ajaxQuery2(page_index+1,false);
		}
		isFistLoad1=false;
        return false;
    }
    
 //]]>
</script>