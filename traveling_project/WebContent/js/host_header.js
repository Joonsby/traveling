$(document).ready(function() {
    // nav menu에 hover시 lnb_menu 나타남
    $(".lnb_menu").hide();
    $(".lnb").mouseenter(function() {
        $(".lnb_menu").stop().slideDown(200);
    });
    $("#menu_nav").mouseleave(function() {
        $('.lnb_menu').stop().slideUp(200);
    });
    
    const addStayBtn = $(".add_stay_btn");
    const hostId = $('#host_id').val()

    addStayBtn.click(function(e) {
        $.ajax({
            type : "POST",
            url : "stay_sel.condb?comm=stay_sel",
            data : {
                hostId : hostId
            },
            success : function(result) {
                const data = result.trim();                
                if (data == "true") {
                    $("#myModal").fadeIn('fast');
                    $("#closeModal").click(function() {
                        $("#myModal").fadeOut('fast');
                    });
                } else if (data == "false") {
                    window.location.href = "add_stay.jsp";
                }
            },
        });
    });
});
