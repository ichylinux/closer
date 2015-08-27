function toggle_feature_dir(feature_dir) {
  $(feature_dir).parent('div.feature_dir').nextUntil('div.feature_dir').toggle(100);
};

function toggle_step_file(step_file) {
  $(step_file).closest('li').next('.step_contents').toggle(100);
  event.stopPropagation();
};

$(document).ready(function() {
  $('li.step').each(function() {
    var messages = $(this).nextUntil('li.step').filter('.message');
    if (messages.length > 0) {
      $(this).find('.val').css('cursor', 'pointer').click(function() {
        messages.toggle(100);
      });
    }
  });
});
