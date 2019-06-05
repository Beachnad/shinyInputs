// vertical-tab-panel.js

$(document).ready(function() {
    $("div.bhoechie-tab-menu>div.list-group").on('click', '> *', function(e) {
        if($(this).hasClass("vt-add-btn")){
            newTab = $(this).siblings().index(0).clone();
            return;
        } else {
            e.preventDefault();
            $(this).siblings('a.active').removeClass("active");
            $(this).addClass("active");
            $(this).css("display", "");
            var index = $(this).index();
            $("div.bhoechie-tab>div.bhoechie-tab-content").removeClass("active");
            $("div.bhoechie-tab>div.bhoechie-tab-content").eq(index).addClass("active");
        }

    });
});