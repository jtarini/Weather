//
//  CityMain.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import ObjectMapper

class CityMain: Mappable {
  
  var temp = 0.0
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    temp <- map["temp"]
  }
  
}
