require "rails_helper"

describe ApplicationHelper, type: :helper do
  describe "#copyright_notice" do
    it "renders the year 2017 in the Copyright notice" do
      expect(copyright_notice).to eq "&copy; 2017 #{AppSettings.brand_name}"
    end
  end
end
