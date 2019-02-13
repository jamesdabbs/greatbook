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

  context 'comparison' do
    let(:a) { Grade.new('A') }
    let(:b_plus) { Grade.new('B+') }
    let(:b) { Grade.new('B') }
    let(:b_minus) { Grade.new('B-') }

    it 'compares one way' do
      expect(a > b).to be true
    end

    it 'compares the other way' do
      expect(b < a).to be true
    end

    it 'compares minus' do
      expect(b_minus < b).to be true
    end

    it 'compares plus' do
      expect(b_plus > b).to be true
    end
  end

  context '#score' do
    it 'has As as 4.0' do
      expect(Grade.new('A').score).to eq 4.0
    end
  end
end
