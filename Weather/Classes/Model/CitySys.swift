//
//  CitySys.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import ObjectMapper

class CitySys: Mappable {
  
  var country = ""
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    country <- map["country"]
  }
  
}
