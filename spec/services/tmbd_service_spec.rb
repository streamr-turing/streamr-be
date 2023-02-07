require "rails_helper"

RSpec.describe TmbdService do
  it '.search_multi', :vcr do
    response = TmbdService.search_multi("Avatar")
    expect(response).to be_a Hash
    expect(response[:results]).to be_a Array
    expect(response[:results][0]).to have_key :media_type
    expect(response[:results][0]).to have_key :id
    expect(response[:results][0]).to have_key :title
    expect(response[:results][0]).to have_key :overview
    expect(response[:results][0]).to have_key :vote_average
    expect(response[:results][0]).to have_key :genre_ids
    expect(response[:results][0]).to have_key :poster_path
    expect(response[:results][0]).to have_key :release_date
  end
  it '.details', :vcr do
    response = TmbdService.details("movie", 278)
    expect(response).to be_a Hash
    expect(response).to have_key :id
    expect(response).to have_key :title
    expect(response).to have_key :overview
    expect(response).to have_key :vote_average
    expect(response[:genres]).to be_an Array
    expect(response[:genres][0]).to be_a Hash
    expect(response[:genres][0]).to have_key :name
    expect(response).to have_key :poster_path
    expect(response).to have_key :release_date
  end
  it '.streaming_service', :vcr do
    response = TmbdService.streaming_service("movie", 278)
    #
    expect(response).to be_a Hash
    expect(response[:results]).to have_key :US
    expect(response[:results][:US]).to have_key :link
    expect(response[:results][:US]).to have_key :buy
    expect(response[:results][:US][:buy]).to be_an Array
    expect(response[:results][:US][:buy][0]).to be_a Hash
    expect(response[:results][:US][:buy][0]).to have_key :provider_name
    expect(response[:results][:US]).to have_key :flatrate
    expect(response[:results][:US][:flatrate][0]).to be_a Hash
    expect(response[:results][:US][:flatrate][0]).to have_key :provider_name
    expect(response[:results][:US]).to have_key :rent
    expect(response[:results][:US][:rent][0]).to be_a Hash
    expect(response[:results][:US][:rent][0]).to have_key :provider_name
  end
end
