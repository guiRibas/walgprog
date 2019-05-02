require 'rails_helper'

describe 'Institution:update', type: :feature do
  let(:admin) { create(:admin) }
  let!(:institution) { create(:institution) }

  before(:each) do
    login_as(admin, scope: :admin)
    visit edit_admins_institution_path(institution)
  end

  context 'when institution is updated', js: true do
    it 'update event' do
      new_name = 'Instituição Teste'
      fill_in 'institution_name', with: new_name

      click_button

      expect(page).to have_current_path admins_institutions_path

      success_message = I18n.t('institutions.success.edit')
      expect(page).to have_flash(:success, text: success_message)
      expect(page).to have_content(new_name)
    end
  end

  error_message = I18n.t('simple_form.error_notification.default_message')
  context 'when institution is not updated', js: true do
    it 'show errors - blank name' do
      fill_in 'institution_name', with: ''
      click_button

      error_default_message = I18n.t('simple_form.error_notification.default_message')
      expect(page).to have_flash(:danger, text: error_default_message)

    end
    it 'show errors - blank acronym' do
      fill_in 'institution_acronym', with: ''
      click_button

      error_default_message = I18n.t('simple_form.error_notification.default_message')
      expect(page).to have_flash(:danger, text: error_default_message)
    end
  end
end
