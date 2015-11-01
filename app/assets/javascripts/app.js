var swap = $(".hero-content");


var setimages = function(){
  $("img", swap ).each(function(){
    var current_url = $(this).attr("src");
    $(this).closest("article").css("background-image", "url(" + current_url + ")");
  });
  return false;
};

setimages();

$('#sidebar-bt, .sidebar__close').on('click', function(e){
  $('body').toggleClass('open');
    $('#overlay-nav').fadeIn('fast');
  e.preventDefault();
});
$('#overlay-nav').on('click', function(e){
    $('body').toggleClass('open');
    $('#overlay-nav').fadeOut('fast');
    e.preventDefault();
});
$(document).ready(function () {

    $('tr:not(:has(td[rowspan])):even').not("thead tr").addClass('oddrow');
    
    $('.signup-modal').on('click',function(){
        $('#signup-modal').fadeIn("fast");
        $('html').addClass('oh');
    });
    $('.become-a-partner-modal').on('click',function(){
        $('#become-a-partner-modal').fadeIn("fast");
        $('html').addClass('oh');
    })
    $('.modal__close,.modal__overlay').on('click',function(){
        $(this).closest(".modal__overlay").fadeOut("fast");
        $('html').removeClass('oh')
    });
    $('.modal__body').on('click',function(){ return false;});
  $('.hello-bar__collapse-bt').on('click',function(){
    $('.hello-bar__content').slideToggle();
    $('.hello-bar__collapse-bt').toggleClass('close');
  });
  $(".main-header").stick_in_parent();
  $(".fancy_title").lettering();
  //collapse menu
  $(".collapse__header").click(function()
  {
    if($(this).hasClass("open"))
    {
      $(this).removeClass("open");
    }
    else
    {
      $(this).closest(".collapse").find(".collapse__header").removeClass("open");
      $(this).addClass("open");
    }
    $(this).next(".collapse__content").slideToggle(200);
    $(this).siblings().next(".collapse__content").slideUp(200);
  });
  
  //tabs
  var tab = $('.tab a'), content = $('.tab__content');
  tab.filter(':first').addClass('active');
  content.filter(':first').show();

  tab.click(function() {
    var index_id = $(this).index();
    tab.removeClass('active').eq(index_id).addClass('active');
    content.hide().eq(index_id).fadeIn(500);
    return false;
  });

  // Datepickers
  $('.datetimepicker input').datetimepicker();

  // Select2s
  $('.select2').select2();

});
$(".big-thumb").on('click', function (e) {
  var height = $(this).find('img').height() + 10;
  if($(this).parent().find('.team__member__info').hasClass('open') && $('.team__member__info').hasClass('open'))
  {
    $(this).parent().find('.team__member__info').css('top',height).toggleClass('open');
  }
  else if($('.team__member__info').hasClass('open'))
  {
    $('.team__member__info').removeClass('open');
    $(this).parent().find('.team__member__info').css('top',height).addClass('open');
  }
  else 
  {
    $(this).parent().find('.team__member__info').css('top',height).addClass('open');
  }
  e.preventDefault();
})

$(window).load(function() {
    $('.flexslider').flexslider({
        animation: "slide",
        controlNav: false
    });
});
