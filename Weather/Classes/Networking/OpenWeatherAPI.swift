//
//  OpenWeatherAPI.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import Moya

// MARK: - Provider setup
private func JSONResponseDataFormatter(_ data: Data) -> Data {
  do {
    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
    let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
    return prettyData
  } catch {
    return data //fallback to original data if it cant be serialized
  }
}

let moyaProvider = MoyaProvider<OpenWeather>()
let OpenWeatherProvider = MoyaProvider<OpenWeather>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

enum OpenWeather {
  
  case citiesByIds(_ ids: String)
  case cityByCoordinate(_ lat: Double, lon: Double)
  
  static let OpenWeatherAPIKey = "---your-OpenWeatherMapAPI-key-here---"
  
}

typealias ParameterDictionary = [String: Any]

extension OpenWeather: Moya.TargetType {
  
  var baseURL: URL {
    return URL(string: "https://api.openweathermap.org/data/2.5")!
  }
  
  var path: String {
    switch self {
      case .citiesByIds:
        return "/group"
      case .cityByCoordinate:
        return "/weather"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Moya.Task {
    var params: ParameterDictionary = ["APPID": OpenWeather.OpenWeatherAPIKey, "units": "metric"]
    switch self {
      case .citiesByIds(let ids):
        params += ["id": ids]
      case .cityByCoordinate(let lat, let lon):
        params += ["lat": lat, "lon": lon]
    }
    
    return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
  }
  
  var headers: [String: String]? {return ["Content-type": "application/json"]}
  
  var sampleData: Data {
    switch self {
      case .citiesByIds(_):
        return """
          {"list": [{"weather": {"icon": "03d"}, "main": {"temp": 34.16}, "wind": {"speed": 4.6}, "clouds": {"all": 30}, "name": "London"}]}
        """.data(using: String.Encoding.utf8)!
      case .cityByCoordinate(_):
        return """
            {"weather": {"icon": "03d"}, "main": {"temp": 34.16}, "wind": {"speed": 4.6}, "clouds": {"all": 30}, "name": "London"}
           """.data(using: String.Encoding.utf8)!
    }
  }
  
}

func += (lhs: inout ParameterDictionary, rhs: ParameterDictionary) {
  for key in rhs.keys {
    lhs[key] = rhs[key]
  }
}
