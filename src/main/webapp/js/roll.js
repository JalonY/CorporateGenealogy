(function(e){e.fn.tabs=function(t){var n={active:0,tit:"li",curClass:"current",trigger:"click"};var r=e.extend(n,t);return this.each(function(){function o(e){s.removeClass(r.curClass).eq(e).addClass(r.curClass);i.hide().eq(e).show()}var t=e(this);var n=t.attr("tab-tit");var i=e("[tab-con="+n+"]");var s=t.find(r.tit);s.bind(r.trigger,function(){o(s.index(this));return false});o(r.active)})}})(jQuery)
//滚动到……
function isScrolledIntoView(o,r){o=$(o);var t=$(window),r=r||0,e=t.scrollTop(),i=e+t.height(),n=o.offset().top+r,f=n+o.height(),h=n>i;if(h)return!1;var l=f>e;return l?!(h&&l):!1}

function goTop(ele){
    $(ele).click(function(){
        $("html, body").animate({ scrollTop: 0});
         return false;
    })
}
function slideNav(ele){ // #nav li
    $(ele).hover(function(){           
        $(this).find("dl").stop().slideToggle();
        $(this).toggleClass("current");
    });
}
$(window).scroll(function(){

    if ($(this).scrollTop() > 800) {
        $('#menu').fadeIn();
    }
    else {
        $('#menu').fadeOut();
    }

});

//手机头部
jQuery(document).ready(function($) {
  var m_menu = $('.m-nav');
    $('.m-trigger').click(function(){
        if( m_menu.is(':visible') ){
            m_menu.hide();
        }else{
            m_menu.show();
        }
        return false;
    });

 });

//右侧边栏
$(document).ready(function(){

    $(".side ul li").hover(function(){
        $(this).find(".sidebox").stop().animate({"width":"175px"},200).css({"background":"#1db5ee","padding-left":"17px"})
    },function(){
        $(this).find(".sidebox").stop().animate({"width":"50px"},200).css({"background":"#000022","padding-left":"0"})   
    });
    
});

//回到顶部
function goTop(){
    $('html,body').animate({'scrollTop':0},600);
}

$('.side2 li').hover(function(){
    $(this).find('.weixin').stop().slideToggle();
})


// 选项卡 鼠标点击
$(".TAB_CLICK li").click(function(){
  var tab=$(this).parent(".TAB_CLICK");
  var con=tab.attr("id");
  var on=tab.find("li").index(this);
  $(this).addClass('hover').siblings(tab.find("li")).removeClass('hover');
  $(con).eq(on).show().siblings(con).hide();
});



$(window).scroll(function(){
    if( $('.ul-show').length > 0 ){
        if(isScrolledIntoView('.ul-show') ){
            moveAbout();
        }
    }

}).scroll();

function moveAbout(){
    $('.ul-show li').each(function(){
        $(this).find('img').each(function(i){
            $(this).delay(i*500).animate({opacity:1});
        })
    })
}


!function ($) {
  var before = 0, after = 0;
  $.scrollToggle = function (callbackUp, callbackDown, callback) {
    $(window).scroll(function () {
      callback && callback();
      after = $(this).scrollTop();
      after <= before ? callbackUp() : callbackDown();
      before = after;
    })
  }
}(jQuery);


$('#fd .weixin').hover(function(){
    $(this).parents('dd').find('.weixin-pic').stop().slideToggle();
})


$(document).ready(function(){
  (function($) {
  var ost = 0;
  $(window).scroll(function() {
    var cOst = $(this).scrollTop();

    if(cOst > 100 && cOst > ost) {
       $('#hd').addClass('fixed').removeClass('default');
    }
    else {
       $('#hd').addClass('default').removeClass('fixed');
    }

    ost = cOst;
  });
  })(jQuery);
})



$(document).ready(function(){
  $('#floatBar li').hover(function() {
      if( $(this).find('.pop').length ){
          $(this).addClass('on').find('.pop').show();
      }
  },function(){
      if( $(this).find('.pop').length ){
          $(this).removeClass('on').find('.pop').hide();
      }
  });
})



