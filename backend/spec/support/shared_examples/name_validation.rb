shared_examples 'name_validation' do
  context 'name' do
    context 'when present' do
      it 'valid' do
        subject.name = 'Art'
        expect(subject).to be_valid
      end
    end

    context 'when blank' do
      it 'invalid' do
        subject.name = ''
        expect(subject).to be_invalid
      end
    end

    context 'when short' do
      it 'invalid' do
        subject.name = 'A'
        expect(subject).to be_invalid
      end
    end

    context 'when very long' do
      it 'invalid' do
        subject.name = 'A'*256
        expect(subject).to be_invalid
      end
    end
  end
end
