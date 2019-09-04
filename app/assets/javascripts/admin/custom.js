function edit_user(id) {
  $.ajax({
    url: '/admin/edit_user',
    type: 'get',
    dataType: 'script',
    data: {'id': id}
  });
}

function show_user(id) {
  $.ajax({
    url: '/admin/show_user',
    type: 'get',
    dataType: 'script',
    data: {'id': id}
  });
}

function reset_errors() {
  $('#error_name', '#error_address', '#error_district_id', '#error_email',
    '#error_password', '#error_password_confirmation').html('');
}

function show_errors(errors, type) {
  $.each(errors, function (value) {
    $.each(this, function (key, error) {
      var element = '<p>' + error + '</p>' 
      $('#error_' + value + type).html(element);
    });
  });
}

$(document).on('click', '#form_new_user', function() {
  $.ajax({
    url: '/admin/new_user',
    type: 'get',
    dataType: 'script'
  });
});

$(document).on('submit', '.new_user', function(e) {
  e.preventDefault();
  form = $('.new_user');

  $.ajax({
    type: form.attr('method'),
    url: form.attr('action'),
    data: form.serialize(),
    success: function (data) {
      reset_errors();
      
      if(data.errors) {
        show_errors(data.errors, '_new');
      } else {
        $('#table_users tr').first().remove();
        $('#table_users').prepend(data.success);
        $('.close_user').click();
        alert(I18n.t("users.add.success"));
      }
    }
  });
});

$(document).on('submit', '.edit_user', function(e) {
  e.preventDefault();
  form = $('.edit_user');

  $.ajax({
    type: form.attr('method'),
    url: form.attr('action'),
    data: form.serialize(),
    success: function (data) {
      reset_errors();
      
      if(data.errors) {
        show_errors(data.errors, '_edit');
      } else {
        $('#email-' + data.success.id).html(data.success.email);
        $('.close_user').click();
        alert(I18n.t("users.edit.success"));
      }
    }
  });
});

$(document).ready(function() {
  $('#id_label_single, .add_product_to_combo_product').select2({theme: 'bootstrap'})
});

$(document).on('click', '#get_store', function() {
  $.ajax({
    url: '/manager/stores',
    type: 'get',
    dataType: 'script'
  });
});

$(document).on('change', '#provinces', function() {
  var province_id = $('#provinces').val();

  $.ajax({
    url: '/manager/districts',
    type: 'get',
    dataType: 'script',
    data: {'id': province_id}
  });
});

$(document).on('submit', '.edit_store', function(e) {
  e.preventDefault();
  form = $('.edit_store');

  $.ajax({
    type: form.attr('method'),
    url: form.attr('action'),
    data: form.serialize(),
    success: function (data) {
      reset_errors();

      if(data.errors) {
        show_errors(data.errors, '_edit');
        alert(I18n.t("stores.edit.fail"));
      } else {
        alert(I18n.t("stores.edit.success"));
        $
        $('#edit_form').html('');
        $('#address-' + data.success.id).html(data.success.address);
        $('#phone-' + data.success.id).html(data.success.phone);
      }
    }
  });
});

$(document).on('click', '#add_store', function() {
  $.ajax({
    url: '/manager/stores/new',
    type: 'get',
    dataType: 'script'
  });
});

$(document).on('submit', '.new_store', function(e) {
  e.preventDefault();
  form = $('.new_store');

  $.ajax({
    type: form.attr('method'),
    url: form.attr('action'),
    data: form.serialize(),
    success: function (data) {
      reset_errors();

      if(data.errors) {
        show_errors(data.errors, '_new');
      } else {
        $('#table_stores').append(data.success);
        alert(I18n.t("stores.add.success"));
      }
    }
  });
});
