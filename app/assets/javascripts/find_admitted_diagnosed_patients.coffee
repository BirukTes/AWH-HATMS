# Page specific javascript, turbolinks is a faster page load
$(document).on 'turbolinks:load', ->
# Page is class in init.coffee
  return unless (page.controller() == 'prescriptions' && page.action() == 'new')

  # On change event of the ward select
  $(document).on('change', '#patient_id_select_find_diagnosed', ->

# Specify url for ajax url
    url = if page.action() == 'new'
      '/search/find_admitted_diagnosed_patients_in_ward'


    if $(this.option).val != '' && url != ''
      console.log('posted for diagnoses')
      $.ajax({
        type: 'GET',
        async: true,
        dataType: 'json',
        url: url,
        data: {
          ward_id_selected: $('#ward_id_select_find_admitted').val(),
          patient_id_selected: $('#patient_id_select_find_diagnosed').val()
        },
        success: (diagnoses_data) ->
          console.log(diagnoses_data)
          # In rare cases, need to show this
          $('<option value="loading">Loading diagnoses...</option>').appendTo('#diagnosis_id_select').attr("selected", true)

          # Remove the existing items which have values and not the blank
          $('#diagnosis_id_select option').each(->
            if $(this).val() != ''
              $(this).remove()
          )

          # Append new values
          $.each(diagnoses_data, (iterator_number, diagnosis) ->
            $option = $('<option value="' + diagnosis[1] + '">' + diagnosis[0] + '</option>').appendTo('#diagnosis_id_select')
          )

          # Enable the select
          $('#diagnosis_id_select').removeAttr('disabled')

          # Make selection if there is one
          if diagnoses_data.length == 1
            $('#diagnosis_id_select option:eq(1)').attr("selected", true)
            $('#btn_submit_find_diagnosed').removeAttr('disabled')
            if ($('.lblMsg').length)
              $('.lblMsg').remove()
          else
            $(document).on('change', '#patient_id_select', ->
              if $('#patient_id_select :selected').val() != ''
                $('#btn_submit_find_diagnosed').removeAttr('disabled')
            )

          # Disable and display msg if there is nothing in the data
          if diagnoses_data.length == 0
            $('#diagnosis_id_select').attr('disabled', 'disabled')
            $('#btn_submit_find_diagnosed').attr('disabled', 'disabled')
            if !($('.lblMsg').length)
# Display msg also button link
              $("""<br/><label class="lblMsg" style="font-weight: bold;">No diagnoses found.
                <a href="/diagnoses/new?ward_id=#{$('#ward_id_select_find_admitted').val() +
                 '&patient_id=' + $('#patient_id_select_find_diagnosed').val()}"
                role="button" class="btn btn-primary">Diagnose Patient</a></label>""").insertAfter('#diagnosis_id_select')

          # Disable Diagnosis select if selected value is empty
          if $('#ward_id_select_find_admitted :selected, #patient_id_select_find_diagnosed  :selected').val() == ''
            $('#diagnosis_id_select, #btn_submit_find_diagnosed').attr('disabled', 'disabled')
            $('#diagnosis_id_select option:eq(0)').attr("selected", true)
            if ($('.lblMsg').length)
              $('.lblMsg').remove()

      }))
