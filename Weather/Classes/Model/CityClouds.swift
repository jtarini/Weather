//
//  CityClouds.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import ObjectMapper

class CityClouds: Mappable {
  
  var all = 0
  
  required convenience init?(map: Map) {
    self.init()
  }
  
  func mapping(map: Map) {
    all <- map["all"]
  }
  
}
