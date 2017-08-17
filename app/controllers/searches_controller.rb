class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'P23SAODAYPMOJIN45GHRIIW5HNQDSOYYSGEMZTG1EVXZJH00'
      req.params['client_secret'] = 'GCD1YWJOVWCSDYA14IIEKAD0I3WIZ3QI5HRU2RAWODO2LE5P'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
