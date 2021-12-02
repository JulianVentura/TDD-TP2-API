require 'spec_helper'

describe 'EnRevision' do
  it 'deberia devolver precio al cotizar' do
    en_revision = EnRevision.new

    expect(en_revision.cotizar(100)).to eq 100
  end
end
