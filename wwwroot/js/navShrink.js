window.onscroll = () => { scrollFunction() }

function scrollFunction() {
    if($(window).width() > 1070) {
        if (document.body.scrollTop > 125 || document.documentElement.scrollTop > 125) {
            $('#header-logo-link').css('display', 'none');
            $('.shrinkNav').css('height', '0px');
        } else {
            $('.shrinkNav').css('height', '130px');
            $('#header-logo-link').css('display', 'inline-block');
        }
    }   
}