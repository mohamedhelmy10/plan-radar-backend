require 'rails_helper'

RSpec.describe SendDueDateReminderJob, type: :job do
  let(:ticket) { create(:ticket) }

  it 'sends an email reminder when the job is performed' do
    expect { SendDueDateReminderJob.perform_at(ticket.id, Time.now) }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
