<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<style>
.monthcell{
box-sizing: border-box;
overflow-y: auto;
   display: block;
   scrollbar:hidden;
   max-height: 100px;; 
}
::-webkit-scrollbar {
    width: 0px;  /* remove scrollbar space */
    background: transparent;  /* optional: just make scrollbar invisible */
}
/* optional: show position indicator in red */
::-webkit-scrollbar-thumb {
    background: #FF0000;
}
.selmnth
{
	left:400px;
	width:99px;
}
.selweek
{
	left:500px;
	width:99px;
}
.selday
{
	left:600px;
	width:99px;
}
div.scrollable
{
width:100%;
height: 150px;
margin: 0;
padding: 0;
overflow-y: scroll
}
.selectDay{
	left:0px;
	width:70px;
	top:20px;
	position:absolute;
}
.selectMonth{
	left:72px;
	width:70px;
	top:20px;
	position:absolute;
}
.selectYear{
	left:144px;
	width:70px;
	top:20px;
	position:absolute;
}
.selectWeek{
	left:0px ;
	width:150px;
	top:20px;
	position:absolute;
	display:none;
}
.go{
	left:216px;
	width:70px;
	top:20px;
	position:absolute;
}
.selectrow{
	background-color:#268CAB;
	vertical-align:middle
}

</style>
<body onload="onloadfn()">
<div id="selectrow" class="selectrow" width="700px" height="90px";  class="" style="width:700px;height:90px;left:15%;top:20px;position:absolute">
<select id="selectDay"  style="height:30px;top:5px;" class="selectDay">
</select id="selectMonth">
<select id="selectMonth" onchange="loadDates()"  style="height:30px;top:5px;"class="selectMonth">
  <option value="0">Jan</option>
  <option value="1">Feb</option>
  <option value="2">Mar</option>
  <option value="3">Apr</option>
  <option value="4">May</option>
  <option value="5">Jun</option>
  <option value="6">Jul</option>
  <option value="7">Aug</option>
  <option value="8">Sep</option>
  <option value="9">Oct</option>
  <option value="10">Nov</option>
  <option value="11">Dec</option>
</select>
<select id="selectYear"   style="height:30px;top:5px;"class="selectYear">

</select>
<select id="selectWeek" style="height:30px;top:5px;"class="selectWeek">

</select>

<select id="selectConfroom" style="position:absolute;width:200px;left:495px;height:30px;top:55px;">
  <option value="Room 1">Room 1</option>
  <option value="Room 2">Room 2</option>
  <option value="Room 3">Room 3</option>
  <option value="Room 4">Room 4</option>
</select>
<button class ="go" id="go" style="color:#FFFFFF;border-color:rgba(31, 82, 105, 1.0);;height:30px;top:5px;position:absolute;background-color:rgba(31, 82, 105, 1.0);" onclick="changeMonth()">Go</button>
<input type="text" readonly id ="selmnth" class ="selmnth" style="font-weight: bold;color:#FFFFFF;text-align:center;border:0px solid; height:38px;top:1px;position:absolute;background-color:rgba(31, 82, 105, 1.0);" onclick="myFunction('month')" value="Month"/>

<input type="text" readonly  id ="selweek" class ="selweek" style="font-weight: bold;color:#FFFFFF;text-align:center;border:0px solid;height:38px;top:1px;position:absolute;background-color:rgba(31, 82, 105, 0.5);" onclick="myFunction('week')" value="Week"/>

<input type="text" readonly id ="selday" class ="selday" style="font-weight: bold;color:#FFFFFF;text-align:center;border:0px solid;height:38px;top:1px;position:absolute;background-color:rgba(31, 82, 105, 0.5);" onclick="myFunction('day')" value="Day"/>
</div>
<table id="header" width="700px" height="30px" cellspacing="0" cellpadding="0"  class="" style="background-color:rgba(31, 82, 105, 1.0);;border: 0px solid black;left:15%;top:120px;position:absolute;"></table>
<table id="calTable" width="700px"  cellspacing="0" cellpadding="0"  class="" style="border: 0px solid black;left:15%;top:150px;position:absolute;z-index:1001"></table>
<table id="meetTable" width="700px" cellspacing="0" cellpadding="0"  class="" style="left:15%;top:150px;position:absolute"></table>
<table id="hourTbl" width="5%" cellspacing="0" cellpadding="0"  class="" style="left:10%;top:150px;position:absolute"></table>
<input type="hidden" name="selDate" id="selDate" value="">
<input type="hidden" name="selCalType" id="selCalType" value="">
<input type="hidden" name="meetingmap" id="meetingmap" value="">
<input type="hidden" name="loadedstartdate" id="loadedstartdate" value="">
<input type="hidden" name="loadedenddate" id="loadedenddate" value="">


<script src="http://code.jquery.com/jquery-1.7.js" 
            type="text/javascript"></script>
<script>
function onloadfn() {
	document.getElementById("selCalType").value='month';
	var d = new Date();
	document.getElementById("selDate").value=d; 
	document.getElementById("selectMonth").value = d.getMonth();
	document.getElementById("selectDay").value = d.getDate();
	document.getElementById("selectYear").value = d.getFullYear();
	var selectYear = document.getElementById("selectYear");
	var length = selectYear.options.length;
	for (var i = 0; i < length; i++) {
		selectYear.remove(0);
	}
	for (var i = d.getFullYear()-1; i<=d.getFullYear()+1; i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		if(d.getFullYear() == i ){
			opt.selected=true;
		}
		selectYear.add(opt);
	}
	loadDates();
	myFunction(document.getElementById("selCalType").value);
}
function loadDates() {
	var d = new Date(document.getElementById("selDate").value);

	var selectDay = document.getElementById("selectDay");
	var length = selectDay.options.length;
	for (var i = 0; i < length; i++) {
		selectDay.remove(0);
	}
	var mont = document.getElementById("selectMonth").value;
	var year = document.getElementById("selectYear").value ;
	var days = 31;
	if(mont==1){
		if(year%4 == 0){
			days =29;
		}else{
			days =28;
		}
	}else if(mont==3 || mont==5 ||mont==8 ||mont==10){
		days = 30;
	}else{
		days =31;
	}
	for (var i = 1; i<=days; i++){
		var opt = document.createElement('option');
		opt.value = i;
		opt.innerHTML = i;
		
		if(d.getDate() == i ){
			opt.selected=true;
		}
		selectDay.add(opt);
	}
	d = new Date(document.getElementById("selDate").value);
		var dte =0;
		var mn=d.getMonth();
		var dy = Math.floor(d.getDate()/7);
		d.setDate(d.getDate()-d.getDay());
		while(mn ==d.getMonth() && d.getDate()!=1){
			dy = d.getDay()+(7);
			d.setDate(d.getDate()-dy);
		}
		document.getElementById("loadedstartdate").value=d; 
		d.setDate(d.getDate()+42);
		document.getElementById("loadedenddate").value=d; 
}
function changeMonth() { 
	 var d = new Date(document.getElementById("selDate").value);
	 if(document.getElementById("selCalType").value =='week'){
		var selectWeek=document.getElementById("selectWeek");
		d =new Date(selectWeek.options[selectWeek.selectedIndex].value);
		
	 }else{
		d.setMonth(document.getElementById("selectMonth").value);
		d.setFullYear(document.getElementById("selectYear").value);
		
		var mont = document.getElementById("selectMonth").value;
		if(mont==1){
			if(d.getFullYear()%4 == 0){
				if(document.getElementById("selectDay").value >29){
				    document.getElementById("selectDay").value=29;
				}
			}else{
				if(document.getElementById("selectDay").value >28){
				    document.getElementById("selectDay").value=28;
				}
			}
		}else if(mont==3 || mont==5 ||mont==8 ||mont==10){
			
				if(document.getElementById("selectDay").value >30){
				    document.getElementById("selectDay").value=30;
				}
			
		}
		d.setDate(document.getElementById("selectDay").value);
		d.setMonth(mont);
	 }
	  document.getElementById("selectMonth").value = d.getMonth();
	 document.getElementById("selectDay").value = d.getDate();
	 document.getElementById("selectYear").value = d.getFullYear();
	 document.getElementById("selDate").value=d;
		loadDates();
	 
	 myFunction(document.getElementById("selCalType").value);
	  
}


function myFunction(calType) {

	document.getElementById("selCalType").value=calType;
	var d = new Date(document.getElementById("selDate").value);
	var monthNames = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]; 
	var go = document.getElementById("go");
	var selectWeek = document.getElementById("selectWeek");
	var selectYear = document.getElementById("selectYear");
	var selectMonth = document.getElementById("selectMonth");
	var selectDay = document.getElementById("selectDay");
	
	var selmnth = document.getElementById("selmnth");
	var selweek = document.getElementById("selweek");
	var selday = document.getElementById("selday");
	
	var hourTbl = document.getElementById("hourTbl");
    var tabl = document.getElementById("calTable");
	var meetTable = document.getElementById("meetTable");
	var header = document.getElementById("header");
	var weekdays = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
	var rowCount = tabl.rows.length;
	for(var i =0; i<rowCount ;i++){
		tabl.deleteRow(0);
	}
	rowCount = meetTable.rows.length;
	for(var i =0; i<rowCount ;i++){
		meetTable.deleteRow(0);
	}
	rowCount = header.rows.length;
	for(var i =0; i<rowCount ;i++){
		header.deleteRow(0);
	}
	rowCount = hourTbl.rows.length;
	for(var i =0; i<rowCount ;i++){
		hourTbl.deleteRow(0);
	}
	
	var hrow = header.insertRow(0);
	
	var mn=d.getMonth();
		var dy = Math.floor(d.getDate()/7);
		d.setDate(d.getDate()-d.getDay());
		while(mn ==d.getMonth() && d.getDate()!=1){
			dy = d.getDay()+(7);
			d.setDate(d.getDate()-dy);
		}

		var length = selectWeek.options.length;
		
		length = selectWeek.options.length;
		for (var i = 0; i < length; i++) {
		 selectWeek.remove(0);
		}
		var dd = new Date(d);
		var ddd = new Date(dd);
		td = new Date(document.getElementById("selDate").value);
		for (var i = 0; i<5; i++){
			var opt = document.createElement('option');
			ddd.setDate(dd.getDate()+6);
			opt.value = dd;
			opt.innerHTML = dd.getDate()+'/'+monthNames[dd.getMonth()] +' - '+ddd.getDate()+'/'+monthNames[ddd.getMonth()];

			if((td.getDate() <= ddd.getDate()) && (td.getDate() >= dd.getDate()) ){
				opt.selected=true;
			}
			selectWeek.add(opt);
			dd.setDate(dd.getDate()+7);
		}
	
		
		d = new Date(document.getElementById("selDate").value);
	if(calType =='month'){
		hourTbl.style.display='none';
		selmnth.style.color='#FFFFFF';
		selweek.style.color='#aaa'
		selday.style.color='#aaa';
		selmnth.style.backgroundColor='rgba(31, 82, 105, 1.0)';
		selweek.style.backgroundColor='rgba(31, 82, 105, 0.5)';
		selday.style.backgroundColor='rgba(31, 82, 105, 0.5)';
		selectWeek.style.display='none';
		selectDay.style.display='none';
		selectYear.style.display='block';
		selectMonth.style.display='block';
		go.style.display='block';
		selectMonth.style.left='5px';
		selectYear.style.left='77px';
		go.style.left='149px';
		for(colnum =0;colnum<7;colnum++){
				var col = hrow.insertCell(colnum);
				col.style.width='100px';
				//col.style.height='40px';
				col.style.border='1px solid #268CAB';
				col.style.verticalAlign = "middle";
				col.style.align='left';
				col.style.fontWeight ='25px';
				col.innerHTML = '<font size="3" color="#FFFFFF"><b>'+weekdays[colnum]+'</b></font>';
				col.style.textAlign='center';
				col.onclick=function(){
					alert('hiii');
					};
				}
		

	}else if(calType =='week'){
		hourTbl.style.display='block';
		var dy=0;
		for(var rownum=0;rownum<24;rownum++){
			var row = hourTbl.insertRow(rownum);
			
				var col = row.insertCell(0);
				col.style.width='100px';
				col.style.height='60px';
				col.style.border='0px solid #268CAB';
				col.style.verticalAlign = "top";
				col.style.textAlign='right';
				if(dy == 0){
					col.innerHTML = "12 am ";
				}else if(dy == 12){
					col.innerHTML = "12 pm ";
				}else if(dy <12){
					col.innerHTML = dy +" am ";
				}else{
					col.innerHTML = (dy-12) +" pm ";
				}
				
				dy++;
			
		}
		selectWeek.style.display='block';
		selectDay.style.display='none';
		selectYear.style.display='none';
		selectMonth.style.display='none';
		go.style.display='block';
		selectWeek.style.left='5px';
		selmnth.style.color='#aaa';
		selweek.style.color='#FFFFFF'
		selday.style.color='#aaa';
		selmnth.style.backgroundColor='rgba(31, 82, 105, 0.5)';
		selweek.style.backgroundColor='rgba(31, 82, 105, 1.0)';
		selday.style.backgroundColor='rgba(31, 82, 105, 0.5)';
		go.style.left='157px';
		var seldat = new Date(selectWeek.options[selectWeek.selectedIndex].value);
		

		for(colnum =0;colnum<7;colnum++){
				var col = hrow.insertCell(colnum);
				col.style.width='100px';
				col.style.height='30px';
				col.style.border='1px solid #268CAB';
				col.style.verticalAlign = "middle";
				col.style.align='left';
				col.innerHTML = '<font size="3" color="#FFFFFF"><b>'+seldat.getDate()+' - '+monthNames[seldat.getMonth()]+'</b></font>';
				seldat.setDate(seldat.getDate()+1);
					col.style.textAlign='center';
				
		}
		
		for(var rownum=0;rownum<24;rownum++){
			var row = tabl.insertRow(rownum);
			for(colnum =0;colnum<7;colnum++){
				var col = row.insertCell(colnum);
				col.style.width='100px';
				col.style.height='60px';
				col.style.border='1px solid #268CAB';
				col.style.verticalAlign = "top";
				col.style.align='left';
				col.onclick=function(){
					location.href="BookNew?tm=rownum";
					};
				//col.innerHTML = '<input type="text"  style="border:1px; width:100%;background-color:FF00FF;left:30px;" value="test" onclick="alert(\'hi\')" />';
			}
		}
		
	}else{
		start:
		hourTbl.style.display='block';
		var dy=0;
		for(var rownum=0;rownum<24;rownum++){
			var row = hourTbl.insertRow(rownum);
			var col = row.insertCell(0);
				col.style.width='100px';
				col.style.height='60px';
				col.style.border='0px solid #268CAB';
				col.style.verticalAlign = "top";
				col.style.textAlign='right';
				if(dy == 0){
					col.innerHTML = "12 am ";
				}else if(dy == 12){
					col.innerHTML = "12 pm ";
				}else if(dy <12){
					col.innerHTML = dy +" am ";
				}else{
					col.innerHTML = (dy-12) +" pm ";
				}
				dy++;
		}
		selmnth.style.color='#aaa';
		selweek.style.color='#aaa'
		selday.style.color='#FFFFFF';
		selmnth.style.backgroundColor='rgba(31, 82, 105, 0.5)';
		selweek.style.backgroundColor='rgba(31, 82, 105, 0.5)';
		selday.style.backgroundColor='rgba(31, 82, 105, 1.0)';
		selectWeek.style.display='none';
		selectDay.style.display='block';
		selectYear.style.display='block';
		selectMonth.style.display='block';
		go.style.display='block';
		selectDay.style.left='5px';
		selectMonth.style.left='77px';
		selectYear.style.left='149px';
		go.style.left='221px';
		var col = hrow.insertCell(0);
		col.style.width='700px';
		col.style.height='30px';
		col.style.verticalAlign = "middle";
		col.style.align='left';
		col.innerHTML =col.innerHTML = '<font size="3" color="#FFFFFF"><b>'+d.getDate()+' - '+monthNames[d.getMonth()]+' - '+d.getFullYear()+'</b></font>';
//		'<font size="3" color="#FFFFFF"><b>'+"Today"+'</b></font>';;
			col.style.textAlign='center';
		
		for(var rownum=0;rownum<24;rownum++){
			var row = tabl.insertRow(rownum);
			
				var col = row.insertCell(0);
				col.style.width='700px';
				col.style.height='60px';
				col.style.border='1px solid #268CAB';
				col.style.verticalAlign = "top";
				col.style.align='left';
				col.onclick=function(){
					location.href='BookNew';
					}
			
		}
		
		
	}
	d = new Date(document.getElementById("selDate").value);
	var loadedstartdate = new Date(document.getElementById("loadedstartdate").value);
	var loadedenddate = new Date(document.getElementById("loadedenddate").value);

	if(document.getElementById("meetingmap").value==''){
		loadMeetings();
	}else if(d<loadedstartdate ||d>loadedenddate){
		loadMeetings();
	}else{
		loadMeetingsTocell();
	}
	
	
}
function clearCell() {

    var tabl = document.getElementById("calTable");
	var rowCount = tabl.rows.length;
	for(var i =0; i<=rowCount ;i++){
		tabl.deleteRow(0);
	}
}
function loadMeetings() {
        $.ajax(
            {
				type: 'GET',
				url: "/org/profile",
				dataType: 'jsonp',
				data:{},
				jsonpCallback: 'apiStatus',
				success: function(data) {
					document.getElementById("meetingmap").value = JSON.stringify(data);
					loadMeetingsTocell();
			
				},
				error: function(xhr, status, error) {
					alert(status + '  iiiiii  ' + error);
				}
			}
		);
    }
function loadMeetingsTocell(){
	
	var data = JSON.parse(document.getElementById("meetingmap").value);
	var meetMap = {};
	for(var i=0;i<data["ReservationList"].length;i++){
		var booking = data["ReservationList"][i];
		
		alert(booking.startDate);
		var meetStrtDte = new Date(booking.startDate);
		alert(meetStrtDte);
		var key = meetStrtDte.getDate()+"-"+ meetStrtDte.getMonth()+"-"+meetStrtDte.getFullYear();
		alert(key);
		var list =  new Array();
		if(meetMap[key] == null){
			meetMap[key]=list;
		}
		list = meetMap[key];
		list.push(booking);
	}
	if(document.getElementById("selCalType").value =='day'){
		var meetTable = document.getElementById("meetTable");
		var mrow = meetTable.insertRow(0);
		mrow.style.height='1440px';
		mrow.style.width='700px';
		var d = new Date(document.getElementById("selDate").value);
		key =  d.getDate()+"-"+ d.getMonth()+"-"+d.getFullYear();
		if(meetMap[key] !=null ){
			list = meetMap[key];
			for(var j=0 ; j<list.length;j++){
				var booking = list[j];
				var meetStrtDte = new Date(booking.startDate);
				var dur = booking.duration
				var newDiv = document.createElement('div');
				var top = (meetStrtDte.getHours()*60)+meetStrtDte.getMinutes();
				newDiv.style.height = dur+"px";
				newDiv.style.backgroundColor='rgba(31, 82, 105, 0.3)';
				newDiv.style.border='1px solid rgba(31, 82, 105, 1.0)';
				//newDiv.innerHTML = booking.reservedByOrgName+" - "+meetStrtDte;
				var col1 = mrow.insertCell(0);
				newDiv.style.width = "698px";
				newDiv.style.top=top+'px';
				newDiv.style.left='1px';
				newDiv.style.position='absolute';
				newDiv.style.textAlign='center';
				newDiv.style.verticalAlign='middle';
				newDiv.onclick = function () {
					alert('hiiii');
				};
				col1.appendChild(newDiv);
			}
		}
	}else if(document.getElementById("selCalType").value =='week'){
		var meetTable = document.getElementById("meetTable");
		var mrow = meetTable.insertRow(0);
		mrow.style.height='1440px';
		mrow.style.width='700px';
		var selectWeek = document.getElementById("selectWeek");
		var seldat = new Date(selectWeek.options[selectWeek.selectedIndex].value);
		
		for(colnum =0;colnum<7;colnum++){
			key =  seldat.getDate()+"-"+ seldat.getMonth()+"-"+seldat.getFullYear();
			var left = seldat.getDay()*100;
			if(meetMap[key] !=null ){
				
				list = meetMap[key];
				for(var j=0 ; j<list.length;j++){
					var booking = list[j];
					var meetStrtDte = new Date(booking.startDate);
					var dur = booking.duration
					var newDiv = document.createElement('div');
					var top = (meetStrtDte.getHours()*60)+meetStrtDte.getMinutes();
					newDiv.style.height = dur+"px";
					newDiv.style.backgroundColor='rgba(31, 82, 105, 0.3)';
					newDiv.style.border='1px solid rgba(31, 82, 105, 1.0)';
					//newDiv.innerHTML = booking.reservedByOrgName;
					var col1 = mrow.insertCell(0);
					newDiv.style.width = "98px";
					newDiv.style.top=top+'px';
					newDiv.style.left=left+'px';
					newDiv.style.position='absolute';
					newDiv.style.textAlign='center';
					newDiv.style.verticalAlign='middle';
					newDiv.onclick = function () {
						alert('hiiii');
					};
					col1.appendChild(newDiv);
				}
			}
			seldat.setDate(seldat.getDate()+1);

		}
	}else{
		var tabl = document.getElementById("calTable");
		tabl.style.height='600px';
		tabl.style.maxHeight='600px';
		d = new Date(document.getElementById("selDate").value);
		var dte =0;
		var mn=d.getMonth();
		var dy = Math.floor(d.getDate()/7);
		d.setDate(d.getDate()-d.getDay());
		while(mn ==d.getMonth() && d.getDate()!=1){
			dy = d.getDay()+(7);
			d.setDate(d.getDate()-dy);
		}
		
		for(var rownum=0;rownum<6;rownum++){
			var row = tabl.insertRow(rownum);
			row.style.height='100px';
			row.className = "monthcell";
			row.style.maxHeight='100px';
			for(colnum =0;colnum<7;colnum++){
				var col = row.insertCell(colnum);
				col.style.width='100px';
				col.style.height='100px';
				col.style.border='1px solid #268CAB';
				col.style.verticalAlign = "top";
				col.style.align='left';
				col.innerHTML = d.getDate();
				col.onclick = function () {
					alert('hiiii');
					
				};
				col.style.maxHeight='100px';
				
				key =  d.getDate()+"-"+ d.getMonth()+"-"+d.getFullYear();
		
				if(meetMap[key] !=null ){
					
					
					list = meetMap[key];
					for(var j=0 ; j<list.length;j++){
						var booking = list[j];
						var meetStrtDte = new Date(booking.startDate);
						var dur = booking.duration
						var newDiv = document.createElement('div');
						var top =0;
						newDiv.style.height = "25px";
						newDiv.style.backgroundColor='rgba(31, 82, 105, 0.3)';
						newDiv.style.border='1px solid rgba(31, 82, 105, 1.0)';
						//newDiv.innerHTML = booking.reservedByOrgName;
						newDiv.style.overflow='hidden';
						newDiv.style.width = "98px";
						newDiv.style.top=top+'px';
						newDiv.style.left='1px';
						
						newDiv.style.textAlign='center';
						newDiv.style.verticalAlign='middle';
						newDiv.onclick = function () {
							alert('hiiii');
						};
						col.appendChild(newDiv);
					}
				}
				d.setDate(d.getDate()+1);
			}
		}
	}
}
</script>

</body>
</html>         
    
