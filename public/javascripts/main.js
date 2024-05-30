$(document).ready(function() {
    $("#datatable").DataTable();
    $(document).on('click', '.delete-button', function(e) {
      e.preventDefault();
      var $button = $(this);
      if (confirm($button.data('confirm'))) {
        $button.closest('form').submit();
      }
    }); 
  });