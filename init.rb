require 'redmine'

require 'email_attach_model_patch'

Redmine::Plugin.register :redmine_email_attach do
  name 'Redmine Email Attach plugin'
  author 'Arron Woods'
  description 'This plugin wraps the incoming email rake add_attachments method, to attach the original email to the issue'
  version '1.0.0'
end
