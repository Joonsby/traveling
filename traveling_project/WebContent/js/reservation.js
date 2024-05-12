window.onload = function () {
    
    buildCalendar();
    buildNextMonthCalendar(); // 다음 달 달력도 빌드
    
    // 버튼에 이벤트 리스너를 추가합니다.
    document.getElementById("people-minus").addEventListener('click', decreaseGuestCount);
    document.getElementById("people-plus").addEventListener('click', increaseGuestCount);
    
    baseRoomPrice = parseInt($("#room-price").val());
    baseStandardPeople = parseInt($("#standard-people").val());
    baseMaximumPeople = parseInt($("#maximum-people").val());
};

let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
let today = new Date();     // 페이지를 로드한 날짜를 저장
today.setHours(0, 0, 0, 0);    // 비교 편의를 위해 today의 시간을 초기화

//선택된 체크인 및 체크아웃 날짜를 저장하기 위한 변수들
let checkInDate = null;
let checkOutDate = null;

let baseRoomPrice; // 1박당 금액
let baseStandardPeople; // 기준인원
let baseMaximumPeople; // 최대인원

// 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
function buildCalendar() {

    let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
    let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

    let tbody_Calendar = document.querySelector(".calendar-left > tbody");
    document.getElementById("calYearLeft").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
    document.getElementById("calMonthLeft").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

    while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
        tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
    }

    let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           

    for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
        let nowColumn = nowRow.insertCell();        // 열 추가
    }

    for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

        let nowColumn = nowRow.insertCell();        // 새 열을 추가하고


        let newDIV = document.createElement("p");
        newDIV.innerHTML = leftPad(nowDay.getDate());        // 추가한 열에 날짜 입력
        newDIV.setAttribute('data-date', formatDate(new Date(nowMonth.getFullYear(), nowMonth.getMonth(), nowDay.getDate())));
        nowColumn.appendChild(newDIV);

        if (nowDay.getDay() == 6) {                 // 토요일인 경우
            nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
        }

        if (nowDay < today) {                       // 지난날인 경우
            newDIV.className = "pastDay";
        }
        else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우           
            newDIV.className = "today";
            newDIV.onclick = function () { choiceDate(this); }
        }
        else {                                      // 미래인 경우
            newDIV.className = "futureDay";
            newDIV.onclick = function () { choiceDate(this); }
        }
    }
}

function buildNextMonthCalendar() {
    let nextMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 1); // 다음달 1일
    let nextMonthLastDate = new Date(nextMonth.getFullYear(), nextMonth.getMonth() + 1, 0); // 다음달 마지막날

    let tbody_CalendarNextMonth = document.querySelector(".calendar-right > tbody");
    document.getElementById("calYearRight").innerText = nextMonth.getFullYear(); // 다음달 연도 숫자 갱신
    document.getElementById("calMonthRight").innerText = leftPad(nextMonth.getMonth() + 1); // 다음달 월 숫자 갱신

    while (tbody_CalendarNextMonth.rows.length > 0) {
        tbody_CalendarNextMonth.deleteRow(tbody_CalendarNextMonth.rows.length - 1);
    }

    let row = tbody_CalendarNextMonth.insertRow();

    for (let j = 0; j < nextMonth.getDay(); j++) {
        let cell = row.insertCell();
        // 이전 달의 날짜를 표시하거나 공백으로 두고 싶으면 여기에 코드 추가
    }

    for (let day = nextMonth; day <= nextMonthLastDate; day.setDate(day.getDate() + 1)) {
        let cell = row.insertCell();
        let newDIV = document.createElement("p");
        newDIV.innerHTML = leftPad(day.getDate());
        newDIV.setAttribute('data-date', formatDate(new Date(nextMonth.getFullYear(), nextMonth.getMonth(), day.getDate())));
        cell.appendChild(newDIV);

        if (day.getDay() == 6) {
            row = tbody_CalendarNextMonth.insertRow();
        }

        if (day < today) {
            newDIV.className = "pastDay";
        } else {
            newDIV.className = "futureDay";
            newDIV.onclick = function () { choiceDate(this); };
        }
    }
}

// 날짜 선택
function choiceDate(newDIV) {
	// 클릭된 날짜가 속한 달력의 연도와 월을 가져옵니다.
    let calendarSide = newDIV.closest('.calendar').classList.contains('calendar-left') ? 'Left' : 'Right';
    let year = document.getElementById(`calYear${calendarSide}`).innerText;
    let month = document.getElementById(`calMonth${calendarSide}`).innerText - 1; // 월은 0부터 시작하므로 1을 빼줍니다.
    let day = newDIV.innerHTML;

    let selectedDate = new Date(year, month, day);

    // 이미 체크인과 체크아웃 날짜가 모두 선택된 경우
    if (checkInDate && checkOutDate) {
        // 사용자에게 날짜를 다시 선택할지 확인
        if (confirm('날짜를 다시 선택하시겠습니까?')) {
            checkInDate = selectedDate;
            checkOutDate = null;
            updateSelectedDatesUI(); // UI 업데이트
            // 선택 표시 업데이트를 위해 모든 날짜의 선택을 해제하고, 현재 선택한 날짜만 표시
            document.querySelectorAll('.futureDay').forEach(div => div.classList.remove('checkInDay', 'checkOutDay', 'choiceDay', 'betweenDays'));
            newDIV.classList.add('checkInDay', 'choiceDay');
        }
    }
    // 체크인 날짜가 아직 선택되지 않았거나, 선택된 날짜가 체크아웃 날짜보다 이전일 경우 체크인 날짜 선택
    else if (!checkInDate || selectedDate < checkInDate) {
        // 기존에 선택된 체크인 날짜가 있으면 클래스 제거
        if (checkInDate) {
            document.querySelector(".checkInDay").classList.remove("checkInDay", "choiceDay");
        }
        checkInDate = selectedDate;
        newDIV.classList.add("checkInDay", "choiceDay");
        // 체크아웃 날짜가 체크인 날짜보다 이전인 경우 해제
        if (checkOutDate && checkOutDate < checkInDate) {
            document.querySelector(".checkOutDay").classList.remove("checkOutDay", "choiceDay");
            checkOutDate = null;
        }
    }
    // 체크아웃 날짜 선택 (체크인 날짜가 이미 선택되어 있고, 선택된 날짜가 체크인 날짜보다 이후일 경우)
    else if (selectedDate > checkInDate) {
        // 기존에 선택된 체크아웃 날짜가 있으면 클래스 제거
        if (checkOutDate) {
            document.querySelector(".checkOutDay").classList.remove("checkOutDay", "choiceDay");
        }
        checkOutDate = selectedDate;
        newDIV.classList.add("checkOutDay", "choiceDay");
    }
    
    updateSelectedDatesUI(); // 선택된 날짜 UI 업데이트
    handleDateChange();
}

// 이전달 버튼 클릭
function prevCalendar() {
    nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
    buildCalendar();    // 달력 다시 생성
    buildNextMonthCalendar();
}
// 다음달 버튼 클릭
function nextCalendar() {
    nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
    buildCalendar();    // 달력 다시 생성
    buildNextMonthCalendar();
}

// input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
function leftPad(value) {
    if (value < 10) {
        value = "0" + value;
        return value;
    }
    return value;
}

//선택된 체크인 및 체크아웃 날짜를 UI에 표시하는 함수
function updateSelectedDatesUI() {
     
     // 체크인 및 체크아웃 날짜를 포맷팅하여 표시합니다.
     if (checkInDate) {
         document.getElementById("check-in-date").innerText = formatDate(checkInDate);
     } else {
         document.getElementById("check-in-date").innerText = '체크인';
     }
     
     if (checkOutDate) {
         document.getElementById("check-out-date").innerText = formatDate(checkOutDate);
     } else {
         document.getElementById("check-out-date").innerText = '체크아웃';
     }

     // 숙박 기간을 계산하고 표시합니다.
     if (checkInDate && checkOutDate) {
         let duration = (checkOutDate - checkInDate) / (1000 * 3600 * 24); // 밀리초 단위의 차이를 일 단위로 변환
         document.getElementById("leave-stay-txt").innerText = duration;
     } else {
         document.getElementById("leave-stay-txt").innerText = '';
     }

     // 체크인 및 체크아웃 날짜가 모두 선택된 경우 사이의 날짜에 betweenDays 클래스를 추가합니다.
     if (checkInDate && checkOutDate) {
         let current = new Date(checkInDate);
         while (current <= checkOutDate) {
             let dayElement = document.querySelector(`[data-date="${formatDate(current)}"]`);
             if (dayElement) {
                 dayElement.classList.add('betweenDays');
             }
             current.setDate(current.getDate() + 1);
         }
     }
}

// 날짜 형식을 YYYY-MM-DD로 포맷팅하는 함수
function formatDate(date) {
    if (!date) return '';
    return date.getFullYear() + '-' + leftPad(date.getMonth() + 1) + '-' + leftPad(date.getDate());
}

//인원수를 감소시키는 함수입니다.
function decreaseGuestCount() {
    let guestCount = parseInt($("#guest-txt").text(), 10); // 현재 UI의 값을 가져와서 업데이트합니다.
    if (guestCount > 0) { // 기준 인원보다 클 때만 감소시킬 수 있습니다.
        guestCount--;
        $("#guest-txt").text(guestCount); // jQuery를 사용하여 UI 업데이트
        $("#people-plus").prop('disabled', false); // 증가 버튼 활성화
    }
    
    if (guestCount <= 0) { // 기준 인원 이하가 되면 감소 버튼 비활성화
        $("#people-minus").prop('disabled', true);
    }
    
    handleGuestCountChange(); // 요금 업데이트 함수 호출
}

// 인원수를 증가시키는 함수입니다.
function increaseGuestCount() {
    let guestCount = parseInt($("#guest-txt").text(), 10); // 현재 UI의 값을 가져와서 업데이트합니다.
    if (guestCount < baseMaximumPeople) { // 최대 인원 이하일 때만 증가시킬 수 있습니다.
        guestCount++;
        $("#guest-txt").text(guestCount); // jQuery를 사용하여 UI 업데이트
        $("#people-minus").prop('disabled', false); // 감소 버튼 활성화
    }
    
    if (guestCount >= baseMaximumPeople) { // 최대 인원에 도달하면 증가 버튼 비활성화
        $("#people-plus").prop('disabled', true);
    }
    
    handleGuestCountChange(); // 요금 업데이트 함수 호출
}


//요금 계산 및 UI 업데이트 함수
function updatePricing() {
	// 설정값
    const extraPersonPrice = 30000; // 추가 인원당 요금
    const currentGuestCount = parseInt($("#guest-txt").text(), 10);
    const baseGuestCount = baseStandardPeople; // 전역변수를 사용합니다.

    // 숙박 일수 계산
    let nightsStayed = checkOutDate ? (checkOutDate - checkInDate) / (1000 * 3600 * 24) : 0;
    
    // 객실 요금 계산
    let totalRoomPrice = nightsStayed * baseRoomPrice; // 전역변수를 사용합니다.
    
    // 추가 인원 요금 계산
    let additionalGuests = currentGuestCount - baseGuestCount;
    let totalExtraPersonPrice = additionalGuests > 0 ? additionalGuests * extraPersonPrice : 0;
    
    // 총 요금 계산
    let finalPrice = totalRoomPrice + totalExtraPersonPrice;

    // UI 업데이트
    $("#total_room_price").text(`￦${formatNumber(totalRoomPrice)}`);
    $("#total_pers_price").text(`￦${formatNumber(totalExtraPersonPrice)}`);
    $("#final-price").text(`￦${formatNumber(finalPrice)}`);
}

// 숫자를 포맷팅하는 함수 (예: 120000 -> 120,000)
function formatNumber(number) {
    return number.toLocaleString('ko-KR');
}

// 숙박 일수가 변경될 때 요금 업데이트
function handleDateChange() {

    updatePricing(); // 요금 업데이트
}

// 이용인원 변경 시 요금 업데이트
function handleGuestCountChange() {

    updatePricing(); // 요금 업데이트
}