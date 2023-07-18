$(document).on('ready', function() {
    // 스크롤 시 헤더
    // window.onscroll = function(){
    //     if($(document).scrollTop() > 1){
    //         $("#A_Header").addClass("header_scroll");
    //         // $("#visual").addClass("scroll");
    //         $("#A_Header").mouseleave(function() {
    //             $(this).addClass('header_scroll');
    //         });
    //     } else {
    //         $("#A_Header").removeClass("header_scroll");
    //         // $("#visual").removeClass("scroll");
    //         $("#A_Header").mouseleave(function() {
    //             $(this).removeClass('header_scroll');
    //             // $('.lnb').stop().slideUp(200);
    //         });
    //     }
    // }

    // Header
    // $(".pc_menu").mouseover(function() {
    //     $(this).parents('#A_Header').addClass('header_scroll');
    // });
    // $(".pc_menu").mouseleave(function() {
    //     $(this).parents('#A_Header').removeClass('header_scroll');
    //     $('.lnb').stop().slideUp(200);
    //     $(".gnb > li").removeClass("active");
    // });


    // $("#A_Header").mouseover(function() {
    //     $(this).addClass('header_scroll');
    // });
    // $("#A_Header").mouseleave(function() {
    //     $(this).removeClass('header_scroll');
    //     $('.lnb_wrap').stop().slideUp(400);
    // });

    // PC 서브 메뉴
    // $(".gnb").mouseover(function() {
    //     $(".lnb_wrap").stop().slideDown(400);
    // });
    // $(".lnb_wrap").mouseleave(function() {
    //     $(this).stop().slideUp(400);
    //     $('.gnb > li').removeClass('active');
    // });

    // $('.lnb > li').mouseover(function() {
    //     var activeLnb = $(this).attr('class');
    //     var lnbNum = activeLnb.substring(3,5);
    //     $('.gnb > li').removeClass('active');
    //     $('.gnb' + lnbNum).addClass('active');
    // });

    // PC 서브 메뉴
    // $(".pc_menu .gnb > li").mouseover(function() {
    //     $(".gnb > li").removeClass("active");
    //     $('.lnb').stop().slideUp(200);
    //     $(this).addClass("active");
    //     $(this).children(".lnb").stop().slideDown(400);
    // });
    // $(".pc_menu .lnb").mouseleave(function() {
    //     $(this).parent('li').removeClass('active')
    //     $(this).stop().slideUp(200);
    // });



    var posY;
    function bodyFreezeScroll() {
        posY = $(window).scrollTop();
        $("html").addClass('fix');
        $("html").css("top",-posY);
    }
    function bodyUnfreezeScroll() {
        $("html").removeAttr('class');
        $("html").removeAttr('style');
        posY = $(window).scrollTop(posY);
    }

    // menu open
    menu_bt = 0;
    $('.menubar').click(function(){
        if( menu_bt == 0 ) {
            bodyFreezeScroll();
            $('.menubar li:eq(0)').animate({'rotate':'45deg', 'top':'9px'},300);
            $('.menubar li:eq(1)').fadeOut();
            $('.menubar li:eq(2)').animate({'rotate':'-45deg', 'top':'9px'},300);

            $(this).addClass('bk');
            $('.m_menu').addClass('on');
            $('#A_Header').addClass("header_scroll");
            setTimeout(function() {
			    $('.m_menu .gnb_wrap').addClass('on');
			}, 100);

            menu_bt = 1;
        } else if( menu_bt == 1 ) {
            bodyUnfreezeScroll();
            $('.menubar li:eq(0)').animate({'rotate':'0', 'top':'0'},300);
            $('.menubar li:eq(1)').fadeIn();
            $('.menubar li:eq(2)').animate({'rotate':'0', 'top':'19px'},300);
            $(this).removeClass('bk');
            // $('#A_Header').removeClass("header_scroll");
            setTimeout(function() {
                $('.m_menu .gnb_wrap').removeClass('on');
            }, 100);
            setTimeout(function() {
                $('.m_menu').removeClass('on');
			}, 300);

            menu_bt = 0;
        }
    });

    $('.m_menu .gnb > li').click(function() {
        $('.m_menu .lnb').slideUp();
      $(this).children(".lnb").stop().slideToggle(400);
 });


});
