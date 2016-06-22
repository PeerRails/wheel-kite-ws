require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:json_r) {JSON.parse(response.body)}

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(json_r["text"]).to eq('OK')
      expect(json_r["message"]).to eq('Kaiji')
    end
  end

  describe "POST #search" do
    before do
      stub_request(:post, "https://localhost:9000/search")
        .with(:body => {location: {long: 40.71330, lat: -74}}, :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Kaiji'})
        .to_return(:status => 200, :body => "{\"eta\": 0.5253301482113608}", :headers => {"Content-Type"=> "application/json"})
    end
    it "returns coordinate" do
      post :search, location: {long: 40.71330, lat: -74}
      expect(json_r["eta"]).to eql(0.5253301482113608)
    end

    it "returns errors" do
      post :search, location: nil
      expect(json_r["error"]).not_to be nil

      post :search, location: {name: "koko"}
      expect(json_r["error"]).not_to be nil

      post :search
      expect(json_r["error"]).not_to be nil
    end
  end

end
