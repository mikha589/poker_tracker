require "test_helper"

class ExportsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test "should enqueue export job" do
    user = User.create!(email: "test_#{Time.current.to_i}@example.com", password: "password123")
    export = Export.create!(user: user, status: "pending")

    assert_enqueued_with(job: ExportSessionsJob, args: [export.id]) do
      ExportSessionsJob.perform_later(export.id)
    end
  end
end
