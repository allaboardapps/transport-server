require "rails_helper"

describe Api::V1::TrainsController, type: :controller do
  describe "#index" do
    it "returns a response" do
      post :index
      expect_json_sizes("data", 1)
    end

    it "includes at least one of the instances" do
      post :index
      expect_json("data", { test: "something" })
    end

    it "returns a status of 200" do
      post :index
      expect_status :ok
    end
  end
end
