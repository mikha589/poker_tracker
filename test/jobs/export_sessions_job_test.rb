require "test_helper"

class ExportSessionsJobTest < ActiveJob::TestCase
  include ActionMailer::TestHelper

  setup do
    @export = exports(:one)
  end

  test "should update status and send success email" do
    @export.update!(status: "pending")

    assert_emails 1 do
      ExportSessionsJob.perform_now(@export.id)
    end

    @export.reload
    assert_equal "completed", @export.status
  end

  test "should be idempotent and skip if already processing" do
    processing_export = exports(:two)
    processing_export.update!(status: "processing")

    assert_no_emails do
      ExportSessionsJob.perform_now(processing_export.id)
    end

    processing_export.reload
    assert_equal "processing", processing_export.status
  end
end
