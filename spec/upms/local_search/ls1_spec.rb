require 'ant-algorithms'
require 'matrix'

describe 'AntAlgorithms::UPMS::LocalSearch::LS1' do
  subject(:ls) do
    AntAlgorithms::UPMS::LocalSearch::LS1.new(
      processing_times: processing_times,
      due_dates: due_dates,
      weights: weights,
      random_generator: Random.new(seed)
    )
  end
  let(:processing_times) do
    Matrix[
      [5, 4, 7],
      [5, 4, 7]
    ]
  end
  let(:due_dates) do
    [8, 4, 6]
  end
  let(:weights) do
    [1,1,1]
  end
  let(:seed) { 2 }
  let(:path) do
    AntAlgorithms::UPMS::PathBuilder::Path.new(
      path: nil,
      cost: nil,
      schedule: [[0,1,2],[]]
      )
  end

  describe '#neighbor' do
    it 'returns new path' do
      new_path = ls.neighbor(path)
      expect(new_path.schedule).to eq [[1, 0, 2], []]
      expect(new_path.path).to eq [[0, 1], [0, 0], [0, 2]]
      expect(new_path.cost).to eq 11
    end

    context 'when choosen mashine has 0 jobs' do
      let(:seed) { 1 }

      it 'returns path' do
        new_path = ls.neighbor(path)
        expect(new_path).to eq path
      end
    end
  end
end
