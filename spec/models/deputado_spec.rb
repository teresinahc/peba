require 'rails_helper'

describe Deputado, type: :model do
  it { should have_many(:despesas) }
end