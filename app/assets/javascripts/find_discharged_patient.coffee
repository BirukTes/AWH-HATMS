# Page specific javascript, turbolinks is a faster page load
$(document).on 'turbolinks:load', ->
# Page is class in init.coffee
  return unless (page.controller() == 'invoices' && page.action() == 'new')

  # On change event of the ward select
  $(document).on('change', '#ward_id_select_find_discharged', ->

# Specify url for ajax url
    url = if page.action() == 'new'
      '/search/find_discharged_without_invoice_patients_in_ward'


    if $(this.option).val != '' && url != ''
      console.log('posted')
      $.ajax({
        type: 'GET',
        async: true,
        dataType: 'json',
        url: url,
        data: {ward_id_selected: $('#ward_id_select_find_discharged').val()},
        success: (patient_data) ->
          console.log(patient_data)
          # In rare cases, need to show this
          $('<option value="loading">Loading patients...</option>').appendTo('#patient_id_select').attr("selected", true)

          # Remove the existing items which have values and not the blank
          $('#patient_id_select option').each(->
            if $(this).val() != ''
              $(this).remove()
          )

          # Append new values
          $.each(patient_data, (iterator_number, patient) ->
            $option = $('<option value="' + patient[1] + '">' + patient[0] + '</option>').appendTo('#patient_id_select')
          )

          # Enable the select
          $('#patient_id_select').removeAttr('disabled')

          # Make selection if there is one
          if patient_data.length == 1
            $('#patient_id_select option:eq(1)').attr("selected", true)
            if ($('.lblMsg').length)
              $('.lblMsg').remove()

          # Append first value if the only one
          if patient_data.length == 0
            $('#patient_id_select').attr('disabled', 'disabled')
            if !($('.lblMsg').length)
              $('<br/><label class="lblMsg" style="font-weight: bold;">No patients in this ward.</label>').insertAfter('#patient_id_select')

          if $('#ward_id_select_find_admitted :selected').val() == ''
            $('#patient_id_select').attr('disabled', 'disabled')
            $('#patient_id_select option:eq(0)').attr("selected", true)
            if ($('.lblMsg').length)
              $('.lblMsg').remove()

      }))
