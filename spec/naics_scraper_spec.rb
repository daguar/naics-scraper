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
  it "returns the correct description for 423120 in 2012 NAICS" do
    @code_content = NaicsScraper.get_content_for_code(423120, 2012)
    @code_content.should eq("This industry comprises establishments primarily engaged in the merchant wholesale distribution of motor vehicle supplies, accessories, tools, and equipment; and new motor vehicle parts (except new tires and tubes).")
  end
  # Issue #2 - May want to make this return the content for the referred code
  it "returns a referential description for 51711 in 2012 NAICS" do
    @code_content = NaicsScraper.get_content_for_code(51711, 2012)
    @code_content.should eq("See industry description for 517110.")
  end
  it "returns nothing for a code without content (ex. 5412 in 2012)" do
    @code_content = NaicsScraper.get_content_for_code(5412, 2012)
    @code_content.should eq("")
  end
  it "returns the correct description for 541120 in 2012 NAICS" do
    @code_content = NaicsScraper.get_content_for_code(541120,2012)
    @code_content.should eq("This industry comprises establishments (except offices of lawyers and attorneys) primarily engaged in drafting, approving, and executing legal documents, such as real estate transactions, wills, and contracts; and in receiving, indexing, and storing such documents.")
  end
end

describe NaicsScraper, "::get_examples_for_code" do
  it "returns a list of illustrative examples for 54119 in 2012" do
    @code_examples = NaicsScraper.get_examples_for_code(54119, 2012)
    example_array = {
      "Notary public services",
      "Process serving services",
      "Paralegal services",
      "Real estate settlement offices",
      "Patent agent services (i.e., patent filing and searching services) Real estate title abstract companies"
    }
    @code_examples.should eq(example_array)
  end
  it "returns nothing for a code without illustrative examples, e.g. 541120 in 2012" do
    @code_examples = NaicsScraper.get_examples_for_code(541120, 2012)
    @code_examples.should be_empty
  end
end

describe NaicsScraper, "::get_crossrefs_for_code" do
  it "returns a list of cross references for 54119 in 2012" do
    @code_crossrefs = NaicsScraper.get_crossrefs_for_code(54119, 2012)
    example_array = {
      "Establishments of lawyers and attorneys primarily engaged in the practice of law are classified in Industry 541110, Offices of Lawyers; and",
      "Establishments of notaries public engaged in activities, such as administering oaths and taking affidavits and depositions, witnessing and certifying signatures on documents, but not empowered to draw and approve legal documents and contracts, are classified in U.S. Industry 541199, All Other Legal Services."
    }
    @code_crossrefs.should eq(example_array)
  end
  it "returns a list of cross references, with a header, for 541211 in 2012" do
    @code_crossrefs = NaicsScraper.get_crossrefs_for_code(541211, 2012)
    # Not sure if this is the best way to store this bit of information, but it's a formatting quirk of the text
    example_array = {
      "Establishments primarily engaged in--",
      "Providing tax return preparation services only--are classified in U.S. Industry 541213, Tax Preparation Services;",
      "Providing payroll processing services only--are classified in U.S. Industry 541214, Payroll Services; and",
      "Providing accounting, bookkeeping, and billing services--are classified in U.S. Industry 541219, Other Accounting Services."
    }
    @code_crossrefs.should eq(example_array)
  end
  it "returns a single cross reference for 541110 in 2012" do
    @code_crossrefs = NaicsScraper.get_crossrefs_for_code(541110, 2012)
    # Should single entries just be part of an array with 1 piece of content?
    @code_crossrefs.should eq("Establishments of legal practitioners (except lawyers or attorneys) primarily engaged in providing specialized legal or paralegal services are classified in Industry 54119, Other Legal Services.")
  end
  it "returns nothing for a code without cross references, e.g. 541120 in 2012" do
    @code_crossrefs = NaicsScraper.get_crossrefs_for_code(541120, 2012)
    @code_crossrefs.should be_empty
  end
end

describe NaicsScraper, "::get_response_for_code" do
  # Part of the purpose of the below is to download pages to test above using VCR
  it "returns OK (success) response for a 2-digit code (51 in 2012)" do
    @response = NaicsScraper.get_response_for_code(51, 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a 3-digit code (519 in 2012)" do
    @response = NaicsScraper.get_response_for_code(519, 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a 4-digit code (5191 in 2012)" do
    @response = NaicsScraper.get_response_for_code(5191, 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a 5-digit code (51912 in 2012)" do
    @response = NaicsScraper.get_response_for_code(51912, 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a 6-digit code (519120 in 2012)" do
    @response = NaicsScraper.get_response_for_code(519120, 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a ranged 2-digit code (31-33 in 2012)" do
    @response = NaicsScraper.get_response_for_code("31-33", 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a ranged 2-digit code (44-45 in 2012)" do
    @response = NaicsScraper.get_response_for_code("44-45", 2012)
    @response.code.should eq(200)
  end
  it "returns OK (success) response for a ranged 2-digit code (48-49 in 2012)" do
    @response = NaicsScraper.get_response_for_code("48-49", 2012)
    @response.code.should eq(200)
  end
end

