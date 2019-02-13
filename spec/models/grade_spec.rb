require 'spec_helper'
require_relative '../../app/models/grade'

RSpec.describe Grade do
  it 'can be initialized' do
    grade = Grade.new('A')
    expect(grade.value).to eq 'A'
  end
end
