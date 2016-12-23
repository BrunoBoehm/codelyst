require "spec_helper"

describe "We have Index pages" do
	describe "there is a /items page" do
		before do
			visit "/items"
		end

		it "responds with a 200 status code" do
			expect(page.status_code).to eq(200)
		end
	end

	describe "there is a /lists page" do
		before do
			visit "/lists"
		end

		it "responds with a 200 status code" do
			expect(page.status_code).to eq(200)
		end
	end

	describe "there is a /versions page" do
		before do
			visit "/versions"
		end

		it "responds with a 200 status code" do
			expect(page.status_code).to eq(200)
		end
	end	
end