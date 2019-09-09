$(document).ready(function() {
  var price_to = new AutoNumeric('#price_from_product', AutoNumeric.getPredefinedOptions()
    .numericPos.dotDecimalCharCommaSeparator);
  $('#price_from_product').on('keyup', function() {
    $('#search_price_lteq').val(price_to.getNumericString());
  });

  var price_to = new AutoNumeric('#price_to_product', AutoNumeric.getPredefinedOptions()
    .numericPos.dotDecimalCharCommaSeparator);
  $('#price_to_product').on('keyup', function() {
    $('#search_price_lteq').val(price_to.getNumericString());
  });
});
