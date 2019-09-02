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

function reset_errors(type) {
  var field = ['name', 'email', 'address',
    'phone', 'password', 'password_confirmation'];
  $.each(field, function (value) {
    $('#error_' + value + type).html('');
  });
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
      reset_errors('_new');
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
      reset_errors('_edit');
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
  $('#id_label_single').select2({theme: 'bootstrap'})
});
