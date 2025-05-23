let selectedId = 'check_in_btn';
let status = null;

$(document).ready(function() {
	const hostId = $('#host_id').val();
    const buttons = $(".btn");
    
    let data = {
    		requestType : 'getCheckInList',
    		hostId : hostId
    	}
    ajaxAsync('/webPage/stay/StayServlet',data,setTable);
    data = null;

    buttons.click(function() {
    	const id = $(this).attr('id');
    	// 선택된 탭은 ajax 통신을 하지 않도록 막음
    	if(selectedId == id){
    		return;
    	}
    	selectedId = id;
    	$('.btn').removeClass('active');
    	$(this).addClass('active');
        if(id == 'check_in_btn'){
        	status = 'checkIn';
        	const data = {
        		requestType : 'getCheckInList',
        		hostId : hostId
        	}
        	ajaxAsync('/webPage/stay/StayServlet',data,setTable);
        } else if(id == 'check_out_btn'){
        	status = 'checkOut';
        	const data = {
        		requestType : 'getCheckOutList',
        		hostId : hostId
        	}
        	ajaxAsync('/webPage/stay/StayServlet',data,setTable);
        } else if(id=='hosting_btn'){
        	status = 'hosting';
        	console.log('hosting_btn');
        } else if(id=='empty_review'){
        	status = 'emptyReview';
        	console.log('empty_reivew');
        }
    });
});

function setTable(result){
	const data = JSON.parse(result);
	const tr = $('#table-div thead tr');
	$('#table-div').empty();
	if(data.length > 0){
		$('#table-div').append('<table><thead></thead><tbody></tbody></table>')
		$('#table-div thead').append('<tr></tr>');
		tr.append('<th>예약 번호</th>');
		tr.append('<th>방 이름</th>');
		tr.append('<th>사용자 이름</th>');
		tr.append('<th>인원 수</th>');
		tr.append('<th>가격</th>');
		tr.append('<th>체크인 날짜</th>');
		tr.append('<th>체크아웃 날짜</th>');
		tr.append('<th>체크인 시간</th>');
		tr.append('<th>체크아웃 시간</th>');
		tr.append('<th>결제 시간</th>');
		$.each(data, function (index, item){
			let row = '<tr>';
			$.each(item, function (key, value){
				if(key != 'roomId' && key != 'hostId'){
					row += `<td>${value}</td>`
				}
			});
			row += '</tr>';
			$('#table-div tbody').append(row);
		});
	} else {
		switch(status){
		case "checkIn":
			$('#table-div').append('<p>오늘의 체크인 정보가 없습니다.</p>');
			break;
		case "checkOut":
			$('#table-div').append('<p>오늘의 체크아웃 정보가 없습니다.</p>');
			break;
		case "hosting":
			$('#table-div').append('<p>현재 호스팅중인 정보가 없습니다.</p>');
			break;
		case "emptyReview":
			$('#table-div').append('<p>답변 안한 후기가 없습니다.</p>');
			break;
		}
	}
}