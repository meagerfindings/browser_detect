# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe 'Find_User_Visits' do
    it 'returns the list of visitors for the email address' do
      email = 'test1@gmail.com'
      twelve_times = 12

      twelve_times.times do
        temp_visitor = Visitor.new(email: email)
        temp_visitor.save

        temp_visitor2 = Visitor.new(email: "test#{rand(200)}@email.com")
        temp_visitor2.save
      end

      expect(find_user_visits(email).count).to eq(twelve_times)
      expect(find_user_visits(email).count).to_not eq(Visitor.all.count)
    end
  end
end
