require 'rails_helper'

RSpec.describe Competition do
  describe 'relationships' do
    it { should have_many(:entrants) }
    it { should have_many(:teams).through(:entrants) }
  end
end
