class ApplicationController < ActionController::Base
  include ErrorHandling

  allow_browser versions: :modern

  stale_when_importmap_changes

  before_action :authenticate_user!
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
