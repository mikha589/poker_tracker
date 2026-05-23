class ExportSessionsJob < ApplicationJob
  queue_as :default

  retry_on StandardError, wait: :exponentially_longer, attempts: 3

  discard_on StandardError do |job, error|
    export_id = job.arguments.first

    export = Export.find_by(id: export_id)

    if export

      export.update(status: "failed")

      ExportMailer.failure_email(export.user).deliver_now

    end
  end

  def perform(export_id)
    export = Export.find(export_id)

    return if %w[processing completed].include?(export.status)

    export.update!(status: "processing")

    user = export.user

    csv_data = CSV.generate(headers: true, encoding: "UTF-8") do |csv|
      csv << ["Дата", "Место", "Формат", "Ставки", "Длительность (мин)", "Buy-in", "Cashout", "Profit", "Теги"]

      user.poker_sessions.find_each do |session|
        csv << [

          session.date&.strftime("%Y-%m-%d"),

          session.location,

          session.game_format,

          session.limit,

          session.duration,

          session.buy_in / 100.0,

          session.cashout / 100.0,

          session.profit / 100.0,

          session.tags.to_s

        ]
      end
    end

    export.file.attach(
      io: StringIO.new(csv_data),

      filename: "poker_sessions_#{Time.current.to_i}.csv",

      content_type: "text/csv"
    )

    export.update!(status: "completed")

    ExportMailer.success_email(export).deliver_now
  end
end
