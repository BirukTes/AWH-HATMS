# Parent of all mailers.
#
# @author Bereketab Gulai
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
