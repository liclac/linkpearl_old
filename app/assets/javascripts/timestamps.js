$(document).on('page:change', function() {
  $('[data-adjust]').each(function() {
    var s = $(this).data('adjust');
    var f = $(this).data('adjust-format') || undefined;
    
    var m = moment.utc(s, "YYYY-MM-DD HH:mm:ss [UTC]");
    $(this).text(m.local().format(f));
  });
});
