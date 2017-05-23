# Redmine Email Attachment Plugin

This plugin attaches the HTML and raw source of the incoming email as attachments of the issue. Useful when Redmine has stripped out formatting/text that you need in the email rake.

## Getting started

### 1. Install the plugin

1. Checkout/download the plugin, and place it in your plugins directory (i.e. plugins/redmine_email_attach)
2. Run the redmine plugin rake:
    `rake redmine:plugins:migrate RAILS_ENV=production`
3. Run your email rake (e.g. `redmine:email:receive_imap`)

More detailed instructions are available on the Redmine wiki: http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin

## Assumptions

* Redmine 3 running on a *nix-like system.
* A working email rake

## Troubleshooting

### Check your logfile

If you run into issues, your Redmine logfile might have some valuable information. The logfile is usually found in your Redmine directory in `log/production.log`.

### Check plugin installation procedure

http://www.redmine.org/projects/redmine/wiki/Plugins

## Thanks

Kudos to Joe Darkless for the inspiration and code snippet found in the patch on Redmine issue #8642: https://www.redmine.org/issues/8462

Peter Pfläging <peter@pflaeging.net> for email attachment naming improvements
