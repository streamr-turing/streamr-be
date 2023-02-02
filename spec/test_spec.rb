require 'rails_helper'

RSpec.describe 'setting up CICD' do 
  it 'has a test' do 
    expect(true).to eq(true)
  end

  it 'has a failing test' do 
    expect("sean").to eq("shawn")
  end
end