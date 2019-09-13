function edit_user(id) {
  $.ajax({
    url: '/admin/users/'+ id +'/edit',
    type: 'get',
    dataType: 'script'
  });
}

function show_user(id) {
  $.ajax({
    url: '/admin/users/'+ id,
    type: 'get',
    dataType: 'script'
  });
}

function reset_errors() {
  $('.my_error').html('');
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
    url: '/admin/users/new',
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
        $('#message_store').addClass('alert-danger d-block');
        $('#message_store').removeClass('alert-success');
        $('#content_store').html(I18n.t("stores.edit.error"));
      } else {
        $('#message_store').addClass('alert-success d-block');
        $('#message_store').removeClass('alert-danger');
        $('#content_store').html(I18n.t("stores.edit.success"));
        $('#store_form').html('');
        $('#address-' + data.success.id).html(data.success.address);
        $('#phone-' + data.success.id).html(data.success.phone);
      }
      close_alert();
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
        $('#message_store').addClass('alert-danger d-block');
        $('#message_store').removeClass('alert-success');
        $('#content_store').html(I18n.t("stores.add.error"));
      } else {
        $('#table_stores').append(data.success);
        $('#store_form').html('');
        $('#message_store').addClass('alert-success d-block');
        $('#message_store').removeClass('alert-danger');
        $('#content_store').html(I18n.t("stores.add.success"));
      }
      close_alert();
    }
  });
});

$(document).on('change', '.bill_status', function() {
  var id = $(this).attr('bill_id');
  var status = $(this).val();

  $.ajax({
    url: '/manager/bills/' + id,
    type: 'put',
    dataType: 'json',
    data: {'status': status},
    success: function(data) {
      if(data.state == "success") {
        alert(I18n.t("bills.edit.success"));
      } else {
        alert(I18n.t("bills.edit.error"));
      }
    }
  });
});

$(document).on('click', '#get_store', function() {
  $.ajax({
    url: '/manager/stores',
    type: 'get',
    dataType: 'script'
  });
});

function close_alert() {
  setTimeout(function() {
    $("#message_store").addClass('d-none');
    $("#message_store").removeClass('d-block');
  }, 2000);
}

$(window).on('popstate', function() {
  location.reload(true);
});
