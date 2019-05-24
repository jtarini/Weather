//
//  CitiesPresenter.swift
//  Weather
//
//  Created by Juliano Tarini on 22/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import RxSwift

class CitiesPresenterImplementation: CitiesPresenter {
  
  var view: CitiesView!
  var service: OpenWeatherService!
  
  private let disposeBag = DisposeBag()
  
  func fetchData(_ cityIds: [String], actualLocation: [String: Double]?) {
    service.getCitiesByIds(cityIds)
      .subscribe { event in
        switch event {
          case .success(var cities):
            if !cities.isEmpty {
              if let location = actualLocation {
                self.service.getCityByCoordinate(location["latitude"]!, lon: location["longitude"]!)
                  .subscribe { event in
                    switch event {
                      case .success(let city):
                        cities.append(city)
                        self.view.reloadCities(cities)
                      case .error(let error):
                        self.view.showError(error)
                        self.view.showEmptyView()
                    }
                  }
                  .disposed(by: self.disposeBag)
              }
              else {
                self.view.reloadCities(cities)
              }
            }
            else {
              self.view.showEmptyView()
            }
          case .error(let error):
            self.view.showError(error)
            self.view.showEmptyView()
        }
      }
      .disposed(by: disposeBag)
  }
  
}
