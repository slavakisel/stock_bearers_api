require 'rails_helper'

describe "/v1/stocks", type: :request do
  describe "POST /v1/stocks" do
    let(:params) {{ stock: { name: "Stock", bearer_name: "Bearer" }}}

    it "creates stock and bearer" do
      expect { post "/v1/stocks", params: params }.
        to change { Stock.count }.by(1).and change { Bearer.count }.by(1)

      expect(response.code).to eq "200"

      expect(json_response_body).to include(
        id: instance_of(Integer),
        name: "Stock",
        bearer: {
          id: instance_of(Integer),
          name: "Bearer"
        }
      )
    end

    context "with invalid params" do
      let(:params) {{ stock: { name: "", bearer_name: "Bearer" }}}

      it "renders errors" do
        expect { post "/v1/stocks", params: params }.
          to change { Stock.count }.by(0).and change { Bearer.count }.by(0)

        expect(response.code).to eq "422"

        expect(json_response_body[:errors]).to include(
          stock: { name: ["can't be blank"] }
        )
      end
    end
  end
end
