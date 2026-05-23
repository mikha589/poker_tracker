class ExportMailer < ApplicationMailer
  def success_email(export)
    @user = export.user

    @download_url = rails_blob_url(export.file, expires_in: 24.hours, disposition: "attachment")

    mail(to: @user.email, subject: "Ваш экспорт сессий готов!")
  end

  def failure_email(user)
    @user = user
    mail(to: @user.email, subject: "Ошибка при экспорте сессий")
  end
end
