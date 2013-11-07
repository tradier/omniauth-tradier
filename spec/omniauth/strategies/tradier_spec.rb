require 'spec_helper'

describe OmniAuth::Strategies::Tradier do
  let(:access_token)    { double('AccessToken', :options => {}) }
  let(:parsed_response) { double('ParsedResponse') }
  let(:response)        { double('Response', :parsed => parsed_response) }

  let(:request)         { double('Request') }

  let(:enterprise_site)          { 'https://some.other.site.com/api' }
  let(:enterprise_authorize_url) { 'https://some.other.site.com/login/oauth/authorize' }
  let(:enterprise_token_url)     { 'https://some.other.site.com/login/oauth/access_token' }
  let(:enterprise) do
    OmniAuth::Strategies::Tradier.new('KEY', 'SECRET',
      {
        :client_options => {
          :site          => enterprise_site,
          :authorize_url => enterprise_authorize_url,
          :token_url     => enterprise_token_url
        }
      }
    )
  end

  subject do
    OmniAuth::Strategies::Tradier.new({})
  end

  before(:each) do
    OmniAuth.config.test_mode = true

    allow(request).to receive(:params).and_return({})
    allow(request).to receive(:cookies).and_return({})
    allow(request).to receive(:env).and_return({})
    allow(subject).to receive(:request).and_return(request)

    allow(subject).to receive(:access_token).and_return(access_token)
  end

  after do
    OmniAuth.config.test_mode = false
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

    describe "should be overrideable" do
      it "for site" do
        expect(enterprise.options.client_options.site).to eq(enterprise_site)
      end

      it "for authorize url" do
        expect(enterprise.options.client_options.authorize_url).to eq(enterprise_authorize_url)
      end

      it "for token url" do
        expect(enterprise.options.client_options.token_url).to eq(enterprise_token_url)
      end
    end
  end

  context 'scopes' do
    it 'uses the default scopes when none are defined' do
      expect(subject.authorize_params['scope']).to eq(described_class::DEFAULT_SCOPE)
    end

    context 'when explicit scopes are defined' do
      subject do
        OmniAuth::Strategies::Tradier.new('KEY', 'SECRET', :scope => 'trade')
      end

      before do
        allow(request).to receive(:params).and_return({})
        allow(request).to receive(:cookies).and_return({})
        allow(request).to receive(:env).and_return({})
        allow(subject).to receive(:request).and_return(request)
      end

      it 'uses the defined scopes' do
        expect(subject.authorize_params['scope']).to eq('trade')
      end
    end
  end

  describe "#raw_info" do
    it "should use relative paths" do
      access_token.should_receive(:get).with('/v1/user/profile', kind_of(Hash)).and_return(response)
      expect(subject.raw_info).to eq(parsed_response)
    end
  end

  describe '#uid' do
    let(:parsed_response) do
      {'profile' => {'id' => 'foobar'} }
    end

    before do
      access_token.should_receive(:get).with('/v1/user/profile', kind_of(Hash)).and_return(response)
    end

    it "returns the user's id" do
      expect(subject.uid).to eq('foobar')
    end
  end

  describe '#info' do
    let(:parsed_response) do
      {'profile' => {'id' => 'foobar', 'name' => 'Elaine Benes' } }
    end

    before do
      access_token.should_receive(:get).with('/v1/user/profile', kind_of(Hash)).and_return(response)
    end

    it "returns the user's a hash" do
      expect(subject.info).to be_a Hash
      expect(subject.info['name']).to eq('Elaine Benes')
    end
  end

  describe '#extra' do
    let(:parsed_response) do
      {'profile' => {'id' => 'foobar', 'name' => 'Elaine Benes' } }
    end

    before do
      access_token.should_receive(:get).with('/v1/user/profile', kind_of(Hash)).and_return(response)
    end

    it "returns the entire user profile" do
      expect(subject.extra).to be_a Hash
      expect(subject.extra.has_key?(:raw_info)).to be_true
    end
  end
end
