require 'spec_helper'
require 'pry'

describe NaicsScraper, "::get_codes_for_year" do
  before do
    @codes_for_2012 = NaicsScraper.get_codes_for_year(2012)
  end
  it "gets a successful response from the API (or VCR)" do
    @codes_for_2012.response.code.should eq("200")
  end
  it "has items" do
    @codes_for_2012["items"].count.should be > 1
  end
end

describe NaicsScraper, "::get_content_for_code" do
  it "should return the correct description for 423120 in 2012 NAICS" do
    @code_content = NaicsScraper.get_content_for_code(423120, 2012)
    @code_content.should eq("This industry comprises establishments primarily engaged in the merchant wholesale distribution of motor vehicle supplies, accessories, tools, and equipment; and new motor vehicle parts (except new tires and tubes).")
  end
  it "should return the correct description for 42311 in 2012 NAICS" do
    @code_content = NaicsScraper.get_content_for_code(42311, 2012)
    @code_content.should eq("See industry description for 423110.")
  end
end

describe NaicsScraper, "::get_response_for_code" do
  # Part of the purpose of the below is to cache locally some pages to play with
  it "should return a successful response for a 4-digit code (4231 in 2012)" do
    @response = NaicsScraper.get_response_for_code(4231, 2012)
    @response.code.should eq(200)
  end
  it "should return a successful response for a 5-digit code (42311 in 2012)" do
    @response = NaicsScraper.get_response_for_code(42311, 2012)
    @response.code.should eq(200)
  end
  it "should return a successful response for a 6-digit code (423120 in 2012)" do
    @response = NaicsScraper.get_response_for_code(423120, 2012)
    @response.code.should eq(200)
  end
end


