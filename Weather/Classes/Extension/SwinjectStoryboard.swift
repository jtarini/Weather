//
//  SwinjectStoryboard.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import Swinject
import SwinjectStoryboard

extension SwinjectStoryboard {
  
  class func setup() {
    let assembler = Assembler(container: defaultContainer)
    assembler.apply(assemblies: [CitiesAssembly()])
  }
  
}
