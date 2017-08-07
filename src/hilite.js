  $(function(){
    $("pre.pyret-highlight.force-comment, span.pyret-highlight.force-comment").each(function(_,code) {
      var content = $("<span>").addClass("cm-comment").text($(code).text());
      $(code).text("").append(content).addClass("cm-s-default");
    });
    $("pre.pyret-highlight, span.pyret-highlight").each(function(_,code) {
      if ($(code).hasClass("force-comment")) return;
      CodeMirror.runMode($(code).text(), "pyret", code);
      $(code).addClass("cm-s-default");
    });
  });
