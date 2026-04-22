$(document).ready(function(){
	let seconds = 3;
	const countdownText = document.getElementById("countdown-text");
	
	const timer = setInterval(function() {
		seconds--;
		
		if (seconds > 0) {
			countdownText.innerText = seconds + "초 뒤 이전 페이지로 이동합니다.";
		} else {
			clearInterval(timer);
			history.back();
		}
	}, 1000);
	
// 3초 후 자동 이동 (UX 개선)
	setTimeout(function() {
		history.back();
	}, 3000);
});