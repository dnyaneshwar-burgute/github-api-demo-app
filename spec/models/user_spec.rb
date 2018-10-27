require 'rails_helper'

RSpec.describe User, type: :model do
  # TO DO (associations validations)

  describe 'validations' do
    subject { FactoryBot.build(:user, email: 'user1@gmail.com', login: 'user1') }
    # Email
    it { should validate_presence_of(:email).with_message(I18n.t('models.user.email.missing')) }
    it { should validate_uniqueness_of(:email).with_message(I18n.t('models.user.email.non_unique')) }
    it { should validate_length_of(:email).is_at_least(Limits::MINIMUM_EMAIL_LENGTH).with_message(I18n.t('models.user.email.too_short', char_count: Limits::MINIMUM_EMAIL_LENGTH)) }
    it { should validate_length_of(:email).is_at_most(Limits::MAXIMUM_EMAIL_LENGTH).with_message(I18n.t('models.user.email.too_long', char_count: Limits::MAXIMUM_EMAIL_LENGTH)) }
    # Login
    it { should validate_presence_of(:login).with_message(I18n.t('models.user.login.missing')) }
    it { should validate_length_of(:login).is_at_least(Limits::MINIMUM_NAME_LENGTH).with_message(I18n.t('models.user.login.too_short', char_count: Limits::MINIMUM_NAME_LENGTH)) }
    it { should validate_length_of(:login).is_at_most(Limits::MAXIMUM_NAME_LENGTH).with_message(I18n.t('models.user.login.too_long', char_count: Limits::MAXIMUM_NAME_LENGTH)) }
  end

  describe 'email validation' do
    describe 'email length' do
      it 'should be too long' do
        email = SecureRandom.hex(128)
        user = FactoryBot.build(:user, email: email + '@gmail.com')
        expect(user.valid?).to eq(false)
        expect(user.errors[:email]).to eq([I18n.t('models.user.email.too_long', char_count: Limits::MAXIMUM_EMAIL_LENGTH)])
      end
    end

    describe 'positive results' do
      it { should allow_value('good@example.com').for(:email) }
      it { should allow_value('good@example.co.ng').for(:email) }
      it { should allow_value('g.o.o.d.@example.com').for(:email) }
      it { should allow_value('good@sub.example.com').for(:email) }
      it { should allow_value('"good"@example.com').for(:email) }
      it { should allow_value('good.email@sub.example.com').for(:email) }
      it { should allow_value('.@example.com').for(:email) }
      it { should allow_value('other.email-with-dash@example.com').for(:email) }
    end

    describe 'negative results' do
      it { should_not allow_value('bad@example').for(:email) }
      it { should_not allow_value('@example.com').for(:email) }
      it { should_not allow_value('bad.example.com').for(:email) }
    end
  end

  describe "methods" do
    describe "class Methods" do
      describe ".create_with_omniauth(auth)" do
        it 'should create user if auth is valid hash' do
          auth = { provider: 'github', uid: 1, info: { name: 'User1', nickname: 'user1', email: 'user1@gmail.com' } }
          User.create_with_omniauth(auth.with_indifferent_access)
          expect(User.count).to eq(1)
        end

        it 'should be raise exception if auth hash is invalid' do
          auth = { provider: 'github', uid: 1, info: { name: 'User1', nickname: '', email: 'user1@gmail.com' } }
          expect {
            User.create_with_omniauth(auth.with_indifferent_access)
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
    # TO DO
    # instance methods
  end

end