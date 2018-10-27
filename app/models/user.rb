# frozen_string_literal: true

# class User
class User < ApplicationRecord
  validates :email,
    presence: { message: I18n.t('models.user.email.missing') },
    length: {
      minimum: Limits::MINIMUM_EMAIL_LENGTH,
      too_short: I18n.t('models.user.email.too_short', char_count: Limits::MINIMUM_EMAIL_LENGTH),
      maximum: Limits::MAXIMUM_EMAIL_LENGTH, too_long: I18n.t('models.user.email.too_long', char_count: Limits::MAXIMUM_EMAIL_LENGTH)
    },
    format: { with: Validations::EMAIL, message: I18n.t('models.user.email.invalid') },
    uniqueness: { message: I18n.t('models.user.email.non_unique') },
    reduce: true

    validates :login,
    presence: { message: I18n.t('models.user.login.missing') },
    length: { minimum: Limits::MINIMUM_NAME_LENGTH, too_short: I18n.t('models.user.login.too_short', char_count: Limits::MINIMUM_NAME_LENGTH), maximum: Limits::MAXIMUM_NAME_LENGTH, too_long: I18n.t('models.user.login.too_long', char_count: Limits::MAXIMUM_NAME_LENGTH) },
    reduce: true

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
      user.login = auth['info']['nickname']
      user.email = auth['info']['email']
      user.image_url = auth['info']['image']
    end
  end
end
