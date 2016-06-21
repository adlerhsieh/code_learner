require 'spec_helper'
require_relative "../../lib/code/1"

describe '#sum' do
  it { expect(sum(1, 4)).to  eq 10 }
  it { expect(sum(2, 10)).to eq 54 }
  it { expect(sum(5, 8)).to  eq 26 }
end
