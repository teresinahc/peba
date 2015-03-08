require 'rails_helper'

describe Despesa, type: :model do
  it { should belong_to(:deputado) }
end