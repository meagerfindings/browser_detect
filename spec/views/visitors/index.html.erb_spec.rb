# frozen_string_literal: true

require 'rails_helper'

describe 'visitors/index' do
  it 'displays all visitors' do
    assign(:visitors, [
             Visitor.create(email: 'mat.greten@meagerfindings.com'),
             Visitor.create(email: 'mat.greten@kapost.com')
           ])

    render

    expect(rendered).to match(/mat.greten@meagerfindings.com/)
    expect(rendered).to match(/mat.greten@kapost.com/)
  end
end
