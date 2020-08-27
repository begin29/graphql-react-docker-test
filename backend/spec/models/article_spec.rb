require Rails.root.join('spec/support/shared_examples/name_validation.rb')

describe Article do
  describe 'validations' do
    let(:article) { create(:article) }

    it_behaves_like 'name_validation' do
      subject { article }
    end

    context 'story' do
      context 'when present' do
        it 'valid' do
          expect(article.story).to be_present
          expect(article).to be_valid
        end
      end

      context 'when missing' do
        it 'invalid' do
          article.story_id = nil
          expect(article).to be_invalid
        end
      end
    end

    context 'article_type' do
      context 'when correct type' do
        it 'valid' do
          article.article_type = 'facebook'
          expect(article).to be_valid
        end
      end

      context 'when wrong type' do
        it 'invalid' do
          article.article_type = 'youtube'
          expect(article).to be_invalid
        end
      end
    end

  end
end
