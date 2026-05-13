let selectedId = 'check_in_btn';
let status = 'checkIn';

$(document).ready(function() {
	const hostId = $('#host_id').val();
    const buttons = $(".statusBtn");
    ajaxAsync('/stay/check-in-list',null,setTable);
    buttons.click(function() {
    	const id = $(this).attr('id');
    	if (selectedId === id) {
    		return;
    	}
    	selectedId = id;
    	$('.statusBtn').removeClass('active');
    	$(this).addClass('active');
    	const actionMap = {
    		check_in_btn: {
    			status: 'checkIn',
    			url: '/stay/check-in-list'
    		},
    		check_out_btn: {
    			status: 'checkOut',
    			url: '/stay/check-out-list'
    		},
    		hosting_btn: {
    			status: 'hosting',
    			url: null
    		},
    		empty_review: {
    			status: 'emptyReview',
    			url: null
    		}
    	};
    	const action = actionMap[id];
    	if (!action) {
    		return;
    	}
    	status = action.status;
    	if (action.url) {
    		ajaxAsync(action.url, null, setTable);
    	} else {
    		setTable([]);
    	}
    });
});

function setTable(data){
	const $tableDiv = $('#table-div');
	$tableDiv.empty();
	if (!Array.isArray(data) || data.length === 0) {
		appendEmptyMessage($tableDiv, status);
		return;
	}
	appendReservationTable($tableDiv, data);
}

function appendEmptyMessage($target, status) {
	const messageMap = {
		checkIn: '오늘의 체크인 정보가 없습니다.',
		checkOut: '오늘의 체크아웃 정보가 없습니다.',
		hosting: '현재 호스팅중인 정보가 없습니다.',
		emptyReview: '답변 안한 후기가 없습니다.'
	};

	const message = messageMap[status] || '조회된 정보가 없습니다.';

	$target.append(`<p>${message}</p>`);
}

function appendReservationTable($target, data) {
	const columns = [
		{ key: 'reservationId', label: '예약 번호' },
		{ key: 'roomName', label: '방 이름' },
		{ key: 'userName', label: '사용자 이름' },
		{ key: 'personCount', label: '인원 수' },
		{ key: 'price', label: '가격' },
		{ key: 'checkInDate', label: '체크인 날짜' },
		{ key: 'checkOutDate', label: '체크아웃 날짜' },
		{ key: 'checkInTime', label: '체크인 시간' },
		{ key: 'checkOutTime', label: '체크아웃 시간' },
		{ key: 'paymentTime', label: '결제 시간' }
	];
	const $table = $('<table></table>');
	const $thead = $('<thead></thead>');
	const $tbody = $('<tbody></tbody>');
	const $headerRow = $('<tr></tr>');
	columns.forEach(function(column) {
		$headerRow.append(`<th>${column.label}</th>`);
	});
	$thead.append($headerRow);
	data.forEach(function(item) {
		const $row = $('<tr></tr>');

		columns.forEach(function(column) {
			$row.append(`<td>${item[column.key] || ''}</td>`);
		});

		$tbody.append($row);
	});
	$table.append($thead);
	$table.append($tbody);
	$target.append($table);
}