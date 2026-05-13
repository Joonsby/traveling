function replaceAllString(source, find, replacement){
	return source.split( find ).join( replacement );
}

function showModal(headerTxt, bodyTxt){
	const modalEl = document.querySelector('#Modal');
	modalEl.querySelector('.modal-title').textContent = headerTxt;
	modalEl.querySelector('.modal-body p').textContent = bodyTxt;
	
	const bsModal = new bootstrap.Modal(modalEl);
	bsModal.show();
}

function showConfirmModal(headerTxt, bodyTxt, confirmCallback) {
	const modalEl = document.querySelector('#confirmModal');
	const modalTitle = modalEl.querySelector('.modal-title');
	const modalBody = modalEl.querySelector('.modal-body p');
	const confirmBtn = modalEl.querySelector('#confirmOkBtn');

	modalTitle.textContent = headerTxt;
	modalBody.textContent = bodyTxt;

	const bsModal = new bootstrap.Modal(modalEl);

	// 이벤트 중복 방지
	const newConfirmBtn = confirmBtn.cloneNode(true);
	confirmBtn.parentNode.replaceChild(newConfirmBtn, confirmBtn);

	newConfirmBtn.addEventListener('click', function () {
		if (typeof confirmCallback === 'function') {
			confirmCallback();
		}
		bsModal.hide();
	});

	bsModal.show();
}

function ajaxAsync(url,data,successFunc){
	$.ajax({
		type: 'POST',
		url :url,
		data : data || {},
		dataType: "json",
		success: function (result){
			successFunc(result);
		},
        error: function(xhr) {
            console.log('AJAX ERROR');
            console.log('status:', xhr.status);
            console.log('response:', xhr.responseText);
        }
	});
}