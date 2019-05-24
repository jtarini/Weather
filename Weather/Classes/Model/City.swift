//
//  City.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import ObjectMapper

class City: Mappable {
  
  var name = ""
  var sys = CitySys()
  var main = CityMain()
  var wind = CityWind()
  var clouds = CityClouds()
  var weathers = [CityWeather]()
  
  var cityWithCountry: String {
    return "\(name), \(sys.country)"
  }
  
  var temperatureWithDegrees: String {
    return "\(main.temp) °С"
  }
  
  var weatherIconUrl: URL {
    return URL(string: "https://openweathermap.org/img/w/\(weathers[0].icon).png")!
  }
  
  var windSpeed: String {
    return "\(wind.speed) m/s"
  }
  
  var cloudsPercent: String {
    return "\(clouds.all)%"
  }
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    name <- map["name"]
    sys <- map["sys"]
    main <- map["main"]
    wind <- map["wind"]
    clouds <- map["clouds"]
    weathers <- map["weather"]
  }
  
}
