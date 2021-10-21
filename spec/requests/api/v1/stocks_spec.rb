require 'rails_helper'

describe "/v1/stocks", type: :request do
  describe "POST /v1/stocks" do
    let(:params) {{ stock: { name: "Stock", bearer_name: "Bearer" }}}

    it "creates stock and bearer" do
      expect { post v1_stocks_path, params: params }.
        to change { Stock.count }.by(1).and change { Bearer.count }.by(1)

      expect(response.code).to eq "201"

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

      it "renders stock errors" do
        expect { post v1_stocks_path, params: params }.
          to change { Stock.count }.by(0).and change { Bearer.count }.by(0)

        expect(response.code).to eq "422"

        expect(json_response_body[:errors]).to include(
          stock: { name: ["can't be blank"] }
        )
      end
    end
  end

  describe "PUT /v1/stocks/:id" do
    let(:params) {{ stock: { name: "Updated Stock", bearer_name: "Bearer" }}}

    let(:bearer) { create(:bearer, name: "Bearer") }
    let!(:stock) { create(:stock, bearer: bearer, name: "Stock") }

    it "creates stock and bearer" do
      put v1_stock_path(stock), params: params

      expect(response.code).to eq "200"

      expect(json_response_body).to include(
        id: stock.id,
        name: "Updated Stock",
        bearer: {
          id: bearer.id,
          name: "Bearer"
        }
      )
    end

    context "with invalid params" do
      let(:params) {{ stock: { name: "", bearer_name: "Bearer" }}}

      it "renders stock errors" do
        put v1_stock_path(stock), params: params

        expect(response.code).to eq "422"

        expect(json_response_body[:errors]).to include(
          stock: { name: ["can't be blank"] }
        )
      end
    end

    context "with invalid id" do
      let(:params) {{ stock: { name: "", bearer_name: "Bearer" }}}

      it "renders not found error" do
        put v1_stock_path(0), params: params

        expect(response.code).to eq "404"

        expect(json_response_body[:errors]).to include(
          message: "Couldn't find Stock with 'id'=0"
        )
      end
    end

    context "with invalid params" do
      let(:params) {{}}

      it "renders bad request error" do
        put v1_stock_path(stock), params: params

        expect(response.code).to eq "400"

        expect(json_response_body[:errors]).to include(
          message: "param is missing or the value is empty: stock"
        )
      end
    end
  end

  describe "GET /v1/stocks" do
    let!(:stocks) { create_list(:stock, 2) }

    it "renders stocks with pagination meta" do
      get v1_stocks_path

      expect(response.code).to eq "200"

      expect(json_response_body).to include(
        stocks: StockSerializer.render_as_json(stocks).map(&:deep_symbolize_keys),
        meta: {
          current_page: 1,
          total_pages: 1
        }
      )
    end
  end

  describe "DELETE /v1/stocks/:id" do
    let!(:stock) { create(:stock) }

    it "soft deletes stock" do
      delete v1_stock_path(stock)

      expect(response.code).to eq "200"

      get v1_stocks_path

      expect(json_response_body).to include(stocks: [])
    end
  end
end
