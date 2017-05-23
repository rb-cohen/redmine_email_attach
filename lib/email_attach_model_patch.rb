# patched by Peter Pfläging <peter@pflaeging.net>
require_dependency 'mail_handler'

module EmailAttachMailHandlerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :add_attachments, :raw_attachment
    end
  end

  module InstanceMethods
    # Adds a rates tab to the user administration page
    def add_attachments_with_raw_attachment(obj)
      add_attachments_without_raw_attachment(obj)
      # add raw email as an attachment
      # Generate Timestamp for filename (Peter Pfläging)
      receivetime = Time.new
      attachname = 'Incoming Email ' + receivetime.strftime("%Y-%m-%d %H:%M:%S%z")
      logger.info "MailHandler: adding raw attachments"

      if (parts = email.all_parts.select {|p| p.mime_type == 'text/html'}).present?
        html_parts = parts.map do |p|
          body_charset = p.charset.respond_to?(:force_encoding) ?
            Mail::RubyVer.pick_encoding(p.charset).to_s : p.charset
            Redmine::CodesetUtil.to_utf8(p.body.decoded, body_charset)
          end.join("</hr>")

          # Generate a file with the main content as HTML file
          obj.attachments << Attachment.create(:container => obj,
            :file => html_parts,
            :filename => attachname + '.html',
            :author => user,
            :content_type => 'text/html')
      end

      # Generate a file from the e-mail Source as .EML file with content type message/RFC822
      # Outlook and Apple Mail are opening these files direct! (PP)
      obj.attachments << Attachment.create(:container => obj,
        :file => email.raw_source,
        :filename => attachname + '.eml',
        :author => user,
        :content_type => 'message/rfc822')
    end

  end
end

MailHandler.send(:include, EmailAttachMailHandlerPatch)
