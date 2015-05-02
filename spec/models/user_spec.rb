require 'rails_helper'

describe User do

  describe '#name' do
    it 'should return full name(first+last)' do
      # given
      first_name = 'John'
      last_name = 'Silva'
      user = FactoryGirl.build(:user, first_name: first_name, last_name: last_name)
      expected = "#{first_name} #{last_name}"

      # when
      result = user.name

      # then
      expect(result).to be_eql expected
    end
  end

  describe '#role?' do
    context 'when is a student' do
      # given
      user = FactoryGirl.build(:user, role: 'student')
      it 'should return true for student' do
        # given
        student = 'student'

        # when
        result = user.role? student

        # then
        expect(result).to be true
      end

      it 'should return false for administrator' do
        # given
        administrator = :administrator

        # when
        result = user.role? administrator

        # then
        expect(result).to be false
      end
    end

    context 'when is an administrator' do
      # given
      user = FactoryGirl.build(:user, role: 'administrator')
      it 'should return true for student' do
        # given
        student = 'student'

        # when
        result = user.role? student

        # then
        expect(result).to be false
      end

      it 'should return true for administrator' do
        # given
        administrator = :administrator

        # when
        result = user.role? administrator

        # then
        expect(result).to be true
      end
    end
  end

  describe '#owner?' do
    context 'when user is owner' do
      it 'should return true' do
        # given
        user = FactoryGirl.create(:user)
        video = FactoryGirl.create(:video, user: user)

        # when
        result = user.owner? video

        # then
        expect(result).to be true
      end
    end

    context 'when user is not owner' do
      it 'should return false' do
        # given
        user = FactoryGirl.create(:user)
        video = FactoryGirl.create(:video)

        # when
        result = user.owner? video

        # then
        expect(result).to be false
      end
    end
  end
  
end
