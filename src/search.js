function getQueryStringMap(){
    var assoc = {};
    window.location.search.substring(1).split('&').forEach(function(v) {
        var pair = v.split('=');
        assoc[pair[0]] = pair[1];
    });
    return assoc;
}

$(function(){
    var header = $('a[name="(part._.Glossary)"]');
    if (header.length == 0) return;
    var qs = getQueryStringMap();
    if (!qs.q) return;
    $('table > tbody > tr > td > p').children().each(function() {
        var item = $(this);
        var link = item;
        if (link.attr('name')) return; // Links from TOC
        if (!link.hasClass('indexlink') && !link.hasClass('multi-link')) {
            // Links that are right after links from TOC
            // They are malformed somehow. Here's a hack to make it work.
            link = link.children().first();
        }
        if (link.children().first().text().toLowerCase().indexOf(qs.q.toLowerCase()) != -1) {
            item.removeClass('hidelink');
        } else {
            item.addClass('hidelink');
        }
    });
});
