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

/**
 * Show amenity content inside the standard #Modal Bootstrap modal.
 * - `amenitySelector` can be a selector string (e.g. '#amenity' or '.amenity') or an Element.
 * - The original .amenity element is cloned so the original stays in place.
 * - The cloned node will have its id removed and its CSS position reset so it displays correctly inside the modal.
 */
function showAmenityModal(headerTxt, amenitySelector){
	const modalEl = document.querySelector('#Modal');
	const modalBody = modalEl.querySelector('.modal-body');

	// Resolve element
	let srcEl = null;
	if(typeof amenitySelector === 'string'){
		srcEl = document.querySelector(amenitySelector);
	} else if(amenitySelector instanceof Element){
		srcEl = amenitySelector;
	}

	if(!srcEl){
		// fallback: just show text
		showModal(headerTxt, '편의시설 정보를 찾을 수 없습니다.');
		return;
	}

	// Clear modal body and append cloned amenity
	modalBody.innerHTML = '';
	const clone = srcEl.cloneNode(true);
	// remove duplicate id to avoid conflicts
	if(clone.id) clone.removeAttribute('id');

	// Ensure the cloned amenity is positioned statically inside the modal so it fits the modal layout
	// but keep other visual styles (.amenity background, padding, border-radius) intact.
	clone.style.position = 'static';
	clone.style.left = '';
	clone.style.top = '';
	clone.style.transform = '';
	clone.style.width = '100%';
	clone.style.display = 'block';
	clone.classList.add('modal-amenity-clone');

	modalBody.appendChild(clone);

	modalEl.querySelector('.modal-title').textContent = headerTxt;

	const bsModal = bootstrap.Modal.getOrCreateInstance(modalEl);

	// remove any id attributes inside the clone to avoid duplicate id conflicts
	clone.querySelectorAll('[id]').forEach(function(el){ el.removeAttribute('id'); });

	// If the cloned content includes the original close button (input[value="닫기"]),
	// wire it to hide the modal instead of manipulating the original overlay.
	var innerClose = clone.querySelector('input[value="닫기"], button[value="닫기"]');
	if(innerClose){
		innerClose.addEventListener('click', function(){ bsModal.hide(); });
		innerClose.style.cursor = 'pointer';
	}

	// When modal hides, remove the clone to avoid stale nodes
	modalEl.addEventListener('hidden.bs.modal', function onHidden(){
		const existing = modalBody.querySelector('.modal-amenity-clone');
		if(existing) existing.remove();
	}, { once: true });

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