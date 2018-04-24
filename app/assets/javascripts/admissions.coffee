# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# JQuery syntax for $(document).ready(function ()... (allows to run a process when the page loads (may not be auto just have it ready))
# -> creates anonymous function
#$ ->
$(document).on('change', '#ward_id_select', ->
  if $(this).val != ''
    console.log('posted')
    $.ajax({
      type: 'GET',
      async: true,
      dataType: 'json',
      url: '/admissions/new',
      data: {ward_id_selected: $('#ward_id_select').val()},
      success: (team_data) ->
        console.log(team_data)
        # In rare cases, need to show this
        $('<option value="loading">Loading teams...</option>').appendTo('#team_id_select').attr("selected", true)

        $('#team_id_select option').each(->
          if $(this).val() != ''
            $(this).remove()
        )

        # Append new values
        $.each(team_data, (iterator_number, team) ->
          $option = $('<option value="' + team.id + '">' + team.name + '</option>').appendTo('#team_id_select')
        )

        # Enable the select
        $('#team_id_select').removeAttr('disabled')

        # Make selection if there is one
        if team_data.length == 1
          $('#team_id_select option:eq(1)').attr("selected", true)
          if ($('.lblMsg').length)
            $('.lblMsg').remove()

        if team_data.length == 0
          $('#team_id_select').attr('disabled', 'disabled')
          if !($('.lblMsg').length)
            $('<br/><label class="lblMsg" style="font-weight: bold;">No teams in this ward.</label>').insertAfter('#team_id_select')

        if $('#ward_id_select :selected').attr('value') == ''
          $('#team_id_select').attr('disabled', 'disabled')
          $('#team_id_select option:eq(0)').attr("selected", true)
          if ($('.lblMsg').length)
            $('.lblMsg').remove()

    }))
