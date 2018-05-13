# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  update_balance = ->
    total = 0
    console.log('subto')
    $('.lineTotal').each(->
      lineTotal = $(this).html()
      # Make sure it is a number in inverse of isNAN() (Not-A-Number)
      if (!isNaN(lineTotal))
        total += Number(lineTotal))

    total = total.toFixed(2)
    $('#invoice_total').html(total)
    $('#amount').val(total)


  update_line_total = ->
    console.log('price')
    # The blur method passed the child, either during, quantity, unitPrice, or tax
    # and updates only the current row, so there is no need to have unique id for each row
    row = $(this).parents('.nested-fields')
    line_total = row.find('.unitPrice').val() * row.find('.quantity').val() * ((row.find('.tax').val() / 100) + 1)
    line_total = line_total.toFixed(2)
    if isNaN(line_total)
# It is a number then, convert to number
      row.find('.lineTotal').html('NaN')
    else
# Just store the value, otherwise
      row.find('.lineTotal').html(line_total)
      row.find('#lineTotal').val(line_total)

    update_balance()


  # Check blur event for quantity, unitPrice, and tax  field
  bind_update = ->
# Blur event is triggered after an element has lost focus, any of these fields
# are volunerable to change, staff may do in unorderly manne
    $('.quantity').blur(update_line_total)
    $('.unitPrice').blur(update_line_total)
    $('.tax').blur(update_line_total)


  # Everytime input is clicked, select
  $('input').click(->
    $(this).select())

  # Update after select
  bind_update()

  #
  #  $(document).on('cocoon:after-insert', ->
  #    bind_update())
  #
  #
  #  $(document).on('cocoon:after-remove', ->
  # Determine whether to show or hide the remove button
  # After insert of another row
  $(document).on('cocoon:after-insert', ->
# Attach blur events to the inserted fields
    bind_update()
    if($(".nested-fields").length > 1)
      $(".remove_fields").eq(0).show()
    else
      $(".remove_fields").eq(0).hide())


  # Determine whether to show or hide the remove button
  # After remove of another row
  $(document).on("cocoon:after-remove", ->
    update_line_total()
    if($(".nested-fields").length == 1)
      $(".remove_fields").eq(0).hide()
    else
      $(".remove_fields").eq(0).show())