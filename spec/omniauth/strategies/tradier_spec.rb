require 'spec_helper'

describe OmniAuth::Strategies::Tradier do
  let(:access_token)    { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response)        { double('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Tradier.new({})
  end

  before(:each) do
    allow(subject).to receive(:access_token).and_return(access_token)
  end

  context "client options" do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq("https://api.tradier.com")
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('https://api.tradier.com/v1/oauth/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('https://api.tradier.com/v1/oauth/accesstoken')
    end
  end

  context "#raw_info" do
    it "should use relative paths" do
      access_token.should_receive(:get).with('/v1/user/profile', kind_of(Hash)).and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end

end
