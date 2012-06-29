if( !window.location.hash && window.addEventListener ){
    window.addEventListener( "load",function() {
                            setTimeout(function(){
                                       window.scrollTo(0, 0);
                                       }, 0);
                            });
}

function is_touch_device() {
    try {
        document.createEvent("TouchEvent");
        return true;
    } catch (e) {
        return false;
    }
}

// remap jQuery to $
(function($){})(window.jQuery);

function buttonIsOn(btnID)
{
    return $(btnID).hasClass('activeButton');
}

$(document).ready(function (){
                  if(is_touch_device()) {
                  // for touch
                  // this class prevents the page from using the :active pseudo-selector
                  $('body').addClass('touchDevice');
                  
                  // loop through the buttons and add events
                  // we are using non-jquery binding because it seems more responsive
                  for(var i=0; i<4; i++) {
                  item = document.getElementById('btn_' + i);
                  
                  // add class touchStart when uses touches button
                  item.addEventListener('touchstart', function(event) {
                                        $(this).addClass('touchStart');
                                        }, false);
                  
                  // remove class touchStart when uses ends touch
                  item.addEventListener('touchend', function(event) {
                                        $(this).toggleClass('activeButton');
                                        }, false);
                  }
                  } else {
                  // for non-touch
                  // toggle class activeButton on click
                  $('.elevatorButtonMin').bind('click', function(){
                                               $(this).toggleClass('activeButton');
                                               return false;
                                               });
                  }
                  });