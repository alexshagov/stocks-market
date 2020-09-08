require 'rails_helper'

RSpec.describe Stocks::Update do
  subject { described_class.new(params, stock,
    dependencies: { create_bearer: create_bearer_action_double}) }

  let(:stock) { build(:stock, bearer: build(:bearer)) }
  let(:create_bearer_action_double) { class_double('Bearers::Create') }
  let(:new_bearer_double) { build(:bearer) }
  let(:params) do
    {
      name: '123',
      bearer: { name: '123' }
    }
  end

  context 'when a new bearer is found by name' do
    before do
      allow(Bearer).to receive(:find_by).with(name: params[:bearer][:name]).and_return(new_bearer_double)
    end

    it 'sets found bearer for a stock' do
      expect(stock).to receive(:assign_attributes).with(name: params[:name], bearer_id: new_bearer_double.id)

      subject.call
    end
  end

  context 'when a new bearer name passed' do
    before do
      allow(Bearer).to receive(:find_by).with(name: params[:bearer][:name]).and_return(nil)
      expect(create_bearer_action_double).to receive(:call)
        .with(name: params[:bearer][:name]).and_return(new_bearer_double)
    end

    it 'sets newly created bearer for a stock' do
      expect(stock).to receive(:assign_attributes).with(name: params[:name], bearer_id: new_bearer_double.id)

      subject.call
    end
  end
end
