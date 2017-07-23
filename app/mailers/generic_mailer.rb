class GenericMailer < ApplicationMailer
  def email_report(user, xls)
    attachments["report.xls"] = {mime_type: "application/xls", content: xls}
    mail(to: user.email, subject: "Cees Report")
  end
end
