# Refs: https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
$ ->
  modal_holder_selector = '#modal-holder'
  modal_selector = '#mainModal'

  $(document).on 'click', 'a[data-modal]', ->
    #Load modal dialog from server
    location = $(this).attr("href")
    $.get location, (data)->
      $(modal_holder_selector).html(data).
      find(modal_selector).modal("show")
    false

  $(document).on 'ajax:success', 'form[data-modal]', (event, data, status, xhr) ->
    url = xhr.getResponseHeader('Location')
    console.log(xhr, data, status, event)
    if url
# Redirect to url
      window.location = url
    else
# Remove old modal backdrop
      $('.modal-backdrop').remove()

      # Replace old modal with new one
      $(modal_holder_selector).html(data).
      find(modal_selector).modal("show")

    false

  $(document).on('ajax:error', 'form[data-modal]', (jqXHR, textStatus, errorThrown) ->
    if (textStatus == 'timeout')
      console.log('The server is not responding')

    if (textStatus == 'error')
      console.log(errorThrown))




