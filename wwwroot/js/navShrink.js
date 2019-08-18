window.onscroll = function() { scrollFunction() }

function scrollFunction() {
    if (document.body.scrollTop > 125 || document.documentElement.scrollTop > 125) {
        var headerLogo = document.getElementById('header-logo-link');
        headerLogo.style.display = 'none';
    } else {
        var headerLogo = document.getElementById('header-logo-link');
        headerLogo.style.display = 'inline-block';
    }
}