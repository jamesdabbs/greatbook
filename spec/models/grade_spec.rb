require 'spec_helper'
require_relative '../../app/models/grade'

RSpec.describe Grade do
  it 'can be initialized' do
    grade = Grade.new('A')
    expect(grade.value).to eq 'A'
  end

  context '#to_s' do
    it 'can produce the string' do
      b = Grade.new('B')
      expect(b.to_s).to eq 'B'
    end
  end
end
