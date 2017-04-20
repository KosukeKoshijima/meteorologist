require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    url_1 = "https://maps.googleapis.com/maps/api/geocode/json?address=" + @street_address.gsub(" ","+")
        parsed_data_1 = JSON.parse(open(url_1).read)
        latitude = parsed_data_1["results"][0]["geometry"]["location"]["lat"]
        longitude = parsed_data_1["results"][0]["geometry"]["location"]["lng"]

        url_2 = "https://api.darksky.net/forecast/39c859fdb19327f978e334d35f6982b5/" + latitude.to_s + "," + longitude.to_s
        parsed_data_2 = JSON.parse(open(url_2).read)


    @current_temperature = parsed_data_2["currently"]["temperature"]

    @current_summary = parsed_data_2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
