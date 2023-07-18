$(document).on('ready', function() {
    // Header
    $("#A_Header").mouseover(function() {
        $(this).addClass('on');
    });
    $("#A_Header").mouseleave(function() {
        $(this).removeClass('on');
        $('.lnb_wrap').stop().slideUp(400);
    });

    // PC 서브 메뉴
    $(".gnb").mouseover(function() {
        $(".lnb_wrap").stop().slideDown(400);
    });
    $(".lnb_wrap").mouseleave(function() {
        $(this).stop().slideUp(400);
        $('.gnb > li').removeClass('active');
    });

    $('.lnb > li').mouseover(function() {
        var activeLnb = $(this).attr('class');
        var lnbNum = activeLnb.substring(3,5);
        $('.gnb > li').removeClass('active');
        $('.gnb' + lnbNum).addClass('active');
    });

    // 언어
    $(".lang p").click(function() {
        $(this).parent().siblings().slideToggle();
    });


    // 스크롤 시 헤더
    window.onscroll = function(){
        if($(document).scrollTop() > 1){
            $("#A_Header").addClass("on");
            $("#A_Header").mouseleave(function() {
                $(this).addClass('on');
            });
        } else {
            $("#A_Header").removeClass("on");
            $("#A_Header").mouseleave(function() {
                $(this).removeClass('on');
                $('.lnb_wrap').stop().slideUp(400);
            });
        }
    }

    $('#nav .tit').click(function () {
        $(this).siblings().slideToggle();
    });
});