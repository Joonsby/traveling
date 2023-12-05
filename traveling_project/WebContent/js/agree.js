$(document).ready(function () {
  // 약관 전체 동의
  $('#agree_all').click(function () {
    $('.agree_checkbox').prop('checked', $(this).prop('checked'));
  });

  $('#agree_btn').on('click',function(e){
    let checkbox1 = $('#agree1_checkbox');
    let checkbox2 = $('#agree2_checkbox');
    if (!checkbox1.prop('checked') || !checkbox2.prop('checked')) {
      e.preventDefault();
      alert("약관에 모두 동의해야 회원가입 페이지로 이동할 수 있습니다.");
  }
  })
});
