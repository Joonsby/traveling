function replaceAllString(source, find, replacement){
	return source.split( find ).join( replacement );
}

function cleanupModalBackdrop(modalEl){
	modalEl.addEventListener('hidden.bs.modal', function onHidden(){
		document.querySelectorAll('.modal-backdrop').forEach(function(el){ el.remove(); });
		if(!document.querySelector('.modal.show')){
			document.body.classList.remove('modal-open');
			document.body.style.overflow = '';
			document.body.style.paddingRight = '';
		}
	}, { once: true });
}

function showModal(headerTxt, bodyTxt){
	const modalEl = document.querySelector('#Modal');
	modalEl.querySelector('.modal-title').textContent = headerTxt;
	modalEl.querySelector('.modal-body p').textContent = bodyTxt;

	const bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);
	cleanupModalBackdrop(modalEl);
	bsModal.show();
}

function showConfirmModal(headerTxt, bodyTxt, confirmCallback) {
	const modalEl = document.querySelector('#confirmModal');
	const modalTitle = modalEl.querySelector('.modal-title');
	const modalBody = modalEl.querySelector('.modal-body p');
	const confirmBtn = modalEl.querySelector('#confirmOkBtn');

	modalTitle.textContent = headerTxt;
	modalBody.textContent = bodyTxt;

	const bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);

	// 이벤트 중복 방지
	const newConfirmBtn = confirmBtn.cloneNode(true);
	confirmBtn.parentNode.replaceChild(newConfirmBtn, confirmBtn);

	newConfirmBtn.addEventListener('click', function () {
		if (typeof confirmCallback === 'function') {
			confirmCallback();
		}
		bsModal.hide();
	});

	cleanupModalBackdrop(modalEl);
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