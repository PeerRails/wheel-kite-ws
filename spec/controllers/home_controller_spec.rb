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
      stub_request(:post, "http://localhost:9000/search")
        .with(:body => "{\"location\":{\"long\":\"40.7133\",\"lat\":\"-74\"}}",
              :headers => {'Connection'=>'close', 'Content-Type'=>'application/json', 'Host'=>'localhost:9000', 'User-Agent'=>'http.rb/1.0.4'})
        .to_return(:status => 200, :body => "{\"eta\": \"0.5253301482113608\"}", :headers => {"Content-Type"=> "application/json"})
    end
    it "returns coordinate" do
      post :search, location: {long: 40.71330, lat: -74}
      expect(json_r["eta"].to_f).to eql(0.5253301482113608)
    end

    it "returns errors if location param is nil" do
      post :search, location: nil
      expect(json_r["error"]).not_to be nil
    end

    it "returns errors if no long or lat param" do
      stub_request(:post, "http://localhost:9000/search").
         with(:body => "{\"location\":{\"long\":null,\"lat\":null}}",
              :headers => {'Connection'=>'close', 'Content-Type'=>'application/json', 'Host'=>'localhost:9000', 'User-Agent'=>'http.rb/1.0.4'}).
         to_return(:status => 200, :body => "{\"error\": \"Not Valid Parameters\"}", :headers => {"Content-Type"=> "application/json"})
      post :search, location: {name: "koko"}
      expect(json_r["error"]).not_to be nil
    end

    it "returns errors if no params" do
      post :search
      expect(json_r["error"]).not_to be nil
    end
  end

end
