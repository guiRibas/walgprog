require 'rails_helper'

describe 'Admins::Event::Sponsor::destroy', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
    @sponsor_event = create(:sponsor_event)
  end

  it 'remove the sponsor of event', js: true do
    visit admins_event_sponsors_path(@sponsor_event.event)

    click_on_destroy_link(admins_event_sponsor_path(@sponsor_event.event, @sponsor_event.institution), alert: true)

    expect(page).to have_current_path admins_event_sponsors_path(@sponsor_event.event)

    success_message = I18n.t('flash.actions.destroy.m', resource_name: SponsorEvent.model_name.human)
    expect(page).to have_flash(:success, text: success_message)

    within('table tbody') do
      expect(page).not_to have_content(@sponsor_event.institution.name)
    end
  end
end