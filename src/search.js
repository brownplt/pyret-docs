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

    var content = $('.content-body');
    var alphaRow = $('.alpha-row');
    var inputBox = $('<input/>', {
        'class': 'searchbox large',
        placeholder: '...search manual...',
        size: "64",
    })
        .val(qs.q ? qs.q : '')
        .on('input', function() {
            var query = inputBox.val();
            if (query != '') {
                alphaRow.addClass('hide');
            } else {
                alphaRow.removeClass('hide');
            }
            content.children().each(function() {
                // An item could be either
                // 1. An anchor (need to skip)
                // 2. A post-anchor (empty span, need to skip)
                // 3. indexlink (need to process)
                // 4. indexlinks (need to process)
                var item = $(this);
                var link = item;
                // skip for anchor and post anchor
                if (link.attr('name') || link.hasClass('post-anchor')) return;
                var linkName = link.children().first().text();
                if (linkName.toLowerCase().indexOf(query.toLowerCase()) != -1) {
                    item.removeClass('hide');
                } else {
                    item.addClass('hide');
                }
            });
        });

    var inputGroup = $('<tr/>').append(
        $('<td/>')
            .append(inputBox)
            .append($('</br>')));
    // a very ugly way to find the appropriate place to insert, but I don't
    // know a better way
    alphaRow.parent().parent().parent().before(inputGroup);
    inputBox.trigger('input');
});
