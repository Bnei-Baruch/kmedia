class Mailer < ActionMailer::Base

  ADMIN = 'archive@kabbalahmedia.info'

  default from: ADMIN

  def comment(data)
    subject = data.subject.blank? ? 'Comment' : data.subject
    from = if data.email.blank?
             ADMIN
           else
             if data.name.blank?
               data.email
             else
               "#{data.name} <#{data.email}>"
             end
           end

    mail(to: ADMIN, from: from, subject: subject) do |format|
      format.text { render text: "Name: #{data.name}\nEmail: #{data.email}\nSubject: #{data.subject}\n\n#{data.comment}" }
    end
  end
end
