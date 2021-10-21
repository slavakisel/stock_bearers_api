require 'rails_helper'

describe Stocks::Create do
  subject(:result) { described_class.call(params) }

  let(:params) {{ name: "Foo", bearer_name: "Bar" }}

  it "creates stock and bearer" do
    expect { result }.to change { Stock.count }.by(1).and change { Bearer.count }.by(1)

    expect(result).to be_success

    expect(result.stock.name).to eq "Foo"
    expect(result.stock.bearer.name).to eq "Bar"
  end

  context "when bearer already exists" do
    let!(:bearer) { create(:bearer, name: "bAR") }

    it "creates stock and reuses bearer" do
      expect { result }.to change { Stock.count }.by(1).and change { Bearer.count }.by(0)

      expect(result).to be_success

      expect(result.stock.name).to eq "Foo"
      expect(result.stock.bearer.id).to eq bearer.id
    end
  end

  context "when stock name is invalid" do
    let(:params) {{ bearer_name: "Bar" }}

    it "does not create records" do
      expect { result }.to change { Stock.count }.by(0).and change { Bearer.count }.by(0)

      expect(result).to be_failure
      expect(result.errors.as_json.symbolize_keys).to eq({
        bearer: {},
        stock: { name: ["can't be blank"] }
      })
    end
  end

  context "when bearer name is invalid" do
    let(:params) {{ name: "Foo" }}

    it "does not create records" do
      expect { result }.to change { Stock.count }.by(0).and change { Bearer.count }.by(0)

      expect(result).to be_failure
      expect(result.errors.as_json.symbolize_keys).to eq({
        bearer: { name: ["can't be blank"] },
        stock: {}
      })
    end
  end
end
