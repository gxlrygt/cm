$(function () {
    
    //variables

    var $chosen = null,
        teamBio = $('.team-item--bio');

    function placeAfter($block) {
        $block.after($('.team-item--bio'));
    };   

    $('.team-items .grid-item').on('click', function() {
        $chosen = $(this);

        $(".flag").fadeOut().delay(100).remove();
        $chosen.append("<div class='flag'/>");
        $('.grid-item').removeClass('active');
        $chosen.addClass('active');

        $('.flag')
            .css({display:'block'})
            .delay(200)
            .animate({opacity: 1}, 520);

        teamBio.removeClass("none");
        var top = $(this).offset().top;
        var $blocks = $(this).nextAll('.grid-item');
        if ($blocks.length == 0) {
            placeAfter($(this));
            return false;
        }
        $blocks.each(function(i, j) {
            if($(this).offset().top != top) {
                placeAfter($(this).prev('.grid-item'));
                return false;
            } else if ((i + 1) == $blocks.length) {
                placeAfter($(this));
                return false;
            }
        });
    });

});

