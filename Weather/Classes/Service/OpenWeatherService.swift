//
//  OpenWeatherService.swift
//  Weather
//
//  Created by Juliano Tarini on 22/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import RxSwift
import Moya_ObjectMapper

class OpenWeatherService {
  
  typealias GetCitiesCompletionHandler = Single<[City]>
  typealias GetCityCompletionHandler = Single<City>
  
  func getCitiesByIds(_ ids: [String]) -> GetCitiesCompletionHandler {
    let idsJoined = ids.joined(separator: ",")
    return moyaProvider.rx.request(.citiesByIds(idsJoined))
      .mapArray(City.self, atKeyPath: "list")
  }
  
  func getCityByCoordinate(_ lat: Double, lon: Double) -> GetCityCompletionHandler {
    return moyaProvider.rx.request(.cityByCoordinate(lat, lon: lon))
      .mapObject(City.self)
  }
  
}
