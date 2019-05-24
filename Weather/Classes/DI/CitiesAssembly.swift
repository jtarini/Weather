//
//  CitiesAssembly.swift
//  Weather
//
//  Created by Juliano Tarini on 23/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class CitiesAssembly: Assembly {
  
  func assemble(container: Container) {
    container.storyboardInitCompleted(CitiesViewController.self) { r, c in
      c.presenter = r.resolve(CitiesPresenter.self)
      c.presenter.view = c
    }
    
    container.register(CitiesPresenter.self) { _ in CitiesPresenterImplementation() }
      .initCompleted { r, c in
        let citiesPresenter = c as! CitiesPresenterImplementation
        citiesPresenter.service = r.resolve(OpenWeatherService.self)
      }
      .inObjectScope(.container)
    
    container.register(OpenWeatherService.self) {_ in OpenWeatherService() }
      .inObjectScope(.container)
  }
  
}
