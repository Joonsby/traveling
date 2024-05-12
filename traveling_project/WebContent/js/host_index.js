$(document).ready(function() {
    const buttons = $(".btn");
    const checkInBtn = $("#check_in_btn");
    const checkOutBtn = $("#check_out_btn");
    const hostinBtn = $("#hosting_btn");
    const emptyReview = $("#empty_review");
    const addStayBtn = $(".add_stay_btn");
    const hostId = $('#host_id').val();

    buttons.click(function() {
        buttons.not(this).css({
            background : "#fff",
            color : "#000",
        });
        $(this).css({
            background : "#1aa3ff",
            color : "#fff",
        });
    });
});
