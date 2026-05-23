class ExportsController < ApplicationController
  def create
    @export = current_user.exports.create!(status: "pending")
    ExportSessionsJob.perform_later(@export.id)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.prepend("flash-messages",
            partial: "shared/flash",
            locals: {message: "Экспорт запущен, ожидайте письма", type: "notice"}),

          turbo_stream.replace("export_form_container", partial: "exports/form")
        ]
      end
    end
  end
end
