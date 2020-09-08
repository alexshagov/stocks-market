require 'rails_helper'

RSpec.describe Stocks::Create do
  subject { described_class.new(params,
    dependencies: { create_bearer: create_bearer_action_double}) }

  let(:create_bearer_action_double) { class_double('Bearers::Create') }
  let(:bearer_double) { instance_double('Bearer') }
  let(:params) do
    {
      name: '123',
      bearer: { name: '123' }
    }
  end

  before do
    allow(SecureRandom).to receive(:uuid).and_return('1')
    expect(create_bearer_action_double).to receive(:call)
      .with(name: params[:bearer][:name]).and_return(bearer_double)
  end

  it 'creates a stock' do
    expect(Stock).to receive(:create!).with(name: params[:name],
      reference: '1',
      bearer: bearer_double)

    subject.call
  end
end
