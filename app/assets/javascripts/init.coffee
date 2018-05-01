class Page
  controller: () =>
    $('meta[name=psj]').attr('controller')
# $('body').data('controller')
  action: () =>
    $('meta[name=psj]').attr('action')
# $('body').data('action')

# Instanciate it
@page = new Page


# https://www.driftingruby.com/episodes/page-specific-javascript-in-ruby-on-rails