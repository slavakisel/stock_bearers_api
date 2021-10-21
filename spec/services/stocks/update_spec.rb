require 'rails_helper'

describe Stocks::Update do
  subject(:result) { described_class.call(stock: stock, **params) }

  let(:params) {{ name: "Updated Stock" }}

  let(:bearer) { create(:bearer, name: "Bearer") }
  let!(:stock) { create(:stock, bearer: bearer, name: "Stock") }

  it "updates stock" do
    expect(result).to be_success

    stock.reload

    expect(stock.name).to eq "Updated Stock"
  end

  context "when bearer_name is provided" do
    let(:params) {{ name: "Updated Stock", bearer_name: "Another Bearer" }}

    it "updates stock and creates new bearer" do
      expect { result }.to change { Bearer.count }.by(1)

      expect(result).to be_success

      stock.reload

      expect(stock.name).to eq "Updated Stock"

      expect(result.stock.bearer.name).to eq "Another Bearer"
      expect(result.stock.bearer.id).not_to eq bearer.id
    end
  end

  context "when stock name is invalid" do
    let(:params) {{}}

    it "does not update stock" do
      expect(result).to be_failure

      stock.reload

      expect(stock.name).to eq "Stock"

      expect(result.errors.as_json.symbolize_keys).to include(
        stock: { name: ["can't be blank"] }
      )
    end
  end
end
