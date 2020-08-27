require Rails.root.join('spec/support/shared_examples/name_validation.rb')

describe Story do
  describe 'validations' do
    let(:article) { create(:article) }
    let(:story) { article.story }

    it_behaves_like 'name_validation' do
      subject { story }
    end

    context 'article' do
      context 'when missing' do
        let(:story) { build(:story) }

        it 'invalid' do
          expect(story.articles).to be_blank
          expect(story).to be_invalid
        end
      end

      context 'when at least one is present' do
        it 'valid' do
          expect(story.articles.any?).to be true
          expect(story).to be_valid
        end
      end
    end
  end
end
