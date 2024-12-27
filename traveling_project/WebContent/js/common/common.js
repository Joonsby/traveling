function replaceAllString(source, find, replacement){
	return source.split( find ).join( replacement );
}

function showModal(modalId,headerTxt,bodyTxt){
	$(modalId).modal('show');
	$('.modal-header h1').text(headerTxt);
	$('.modal-body p').text(bodyTxt);
	$('body').css('overflow','auto');
	$('body').css('padding-right','0');
}

function ajaxAsync(url,data,successFunc){
	$.ajax({
		type: 'POST',
		url :url,
		data : data,
		success: function (result){
			successFunc(result);
		}
	});
}