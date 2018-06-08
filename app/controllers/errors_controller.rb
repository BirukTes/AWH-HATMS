# Handles common (404) system errors to and attempts to redirect back or root path
#
# FIXME redirection is causing issue provide better method
#
# @author Bereketab Gulai
class ErrorsController < ApplicationController
  # Skip authorisation for this controller
  skip_after_action :verify_authorized

  # layout 'errors'
  # https://www.driftingruby.com/episodes/custom-error-pages-with-slack-notification
  #
  #  FROM comment section of the article above
  # This pattern is extremely error-prone. There was once a section for implementing custom error pages in the official Rails guides
  #  that basically suggested the same approach as this episode, which was later removed because of potential issues it could introduce.
  #  In this episode specifically, there is a number of potential issues:
  #
  # It doesn't filter or summarize exception details at all, so depending on how an exception is raised the app would
  #  end up brute forcing your slack channel with a lot of noisy events
  #
  # self.routes only responds to 404 and 500 and can't handle any other HTTP statuses, which results in ActionController::RoutingError
  # in the case of e.g. ActionController::MethodNotAllowed that is mapped to 405 (good luck on adding every single status to config/routes.rb)
  #
  # If the SlackNotifyJob is configured to use an external queue (e.g. sidekiq, RabbitMQ) and an exception occurs due to that queue, it would
  # raise an exception again and show an empty error page to the user (this is actually taken care of with a begin ... rescue ... end block,
  # but still this is an issue that shouldn't exist)
  #
  # The ErrorsController inherits from ApplicationController. This means that if the ApplicationController raises an exception in a before_action,
  #  the ErrorsController would raise the same exception again, which results in the same empty error page situation
  #
  # A much better way would be to use a service like Sentry and configure it to send events to your slack channel.

  # Rollbar will handle reporting

  # Handle all not found errors to previous or login, Devise will handle whether authenticated or not
  def not_found
    flash[:alert] = 'Not found'
    redirect_to(request.referrer || root_path, status: 404)
  end

  #
  def not_acceptable
    flash[:alert] = 'Not acceptable'
    redirect_to(request.referrer || root_path, status: 406)
  end

  # Handles HTTP status 410:
  def gone
    flash[:alert] = 'The page is gone'
    redirect_to(request.referrer || root_path, status: 410)
  end

  # Handle all internal server errors to previous or login, Devise will handle whether authenticated or not
  def internal_server_error
    redirect_to(request.referrer || root_path, alert: 'Internal Server Error', status: 500)
  end
end
