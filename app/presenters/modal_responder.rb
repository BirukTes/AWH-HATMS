# Refs: https://jtway.co/5-steps-to-add-remote-modals-to-your-rails-app-8c21213b4d0c
class ModalResponder < ActionController::Responder
  cattr_accessor :modal_layout
  self.modal_layout = 'layouts/modal'
  # binding.pry
  def render(*args)
    options = args.extract_options!

      options.merge! layout: modal_layout

    controller.render *args, options
  end

  def default_render(*args)
    render(*args)
  end

  def redirect_to(options)
   head :ok, location: controller.url_for(options)

      controller.redirect_to(options)
  end
end