require 'spec_helper'

describe 'EnRevision' do
  it 'deberia devolver precio al cotizar' do
    en_revision = EnRevision.new

    expect(en_revision.cotizar(100)).to eq 100
  end

  it 'deberia ser igual que otro EnRevision' do
    en_revision = EnRevision.new
    en_revision2 = EnRevision.new

    expect(en_revision).to eq en_revision2
  end
end
