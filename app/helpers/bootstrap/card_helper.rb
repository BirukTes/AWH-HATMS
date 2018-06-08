# Bootsrap card helper, provides card methods head, title, body and more
#
# @ref https://www.driftingruby.com/episodes/bootstrap-framework-and-ruby-on-rails
module Bootstrap::CardHelper
  # Container
  def card(options = {})
    options = canonicalize_options(options)
    options = ensure_class(options, %w(card))
    content_tag(:div, options) do
        yield
    end
  end

  # Header
  def card_header(*args, &block)
    bootstrap_generator(*args, 'card-header', :h5, &block)
  end

  # Title
  def card_title(*args, &block)
    bootstrap_generator(*args, 'card-title', :h2, &block)
  end

  # Subtitle
  def card_subtitle(*args, &block)
    bootstrap_generator(*args, 'card-subtitle mb-2 text-muted', :h6, &block)
  end

  # Card body
  def card_body(*args, &block)
    bootstrap_generator(*args, 'card-body', :div, &block)
  end

  # Card text
  def card_text(*args, &block)
    bootstrap_generator(*args, 'card-text', :p, &block)
  end

  # Card list
  def card_list(*args, &block)
    bootstrap_generator(*args, 'list-group list-group-flush', :ul, &block)
  end

  # List items
  def card_list_item(*args, &block)
    bootstrap_generator(*args, 'list-group-item', :li, &block)
  end
end