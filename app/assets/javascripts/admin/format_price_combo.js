$(document).ready(function() {
  var price_from = new AutoNumeric('#price_from_combo', AutoNumeric.getPredefinedOptions()
    .numericPos.dotDecimalCharCommaSeparator);
  $('#price_from_combo').on('keyup', function() {
    $('#search_price_gteq').val(price_from.getNumericString());
  });

  var price_to = new AutoNumeric('#price_to_combo', AutoNumeric.getPredefinedOptions()
    .numericPos.dotDecimalCharCommaSeparator);
  $('#price_to_combo').on('keyup', function() {
    $('#search_price_lteq').val(price_to.getNumericString());
  });
});
