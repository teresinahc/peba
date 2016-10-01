require 'rails_helper'

describe VersaoWebService do
  let(:file_path) { './spec/fixtures/empty-file' }

  context '#atualizado?' do
    subject { VersaoWebService }

    it 'should return true if there is no record with that sha1hash' do
      expect(subject.atualizado?(file_path)).to be_truthy
    end

    it 'should return false if there is record with that sha1hash' do
      subject.create(url: file_path, sha1hash: 'da39a3ee5e6b4b0d3255bfef95601890afd80709')
      expect(subject.atualizado?(file_path)).to be_falsey
    end
  end
end
