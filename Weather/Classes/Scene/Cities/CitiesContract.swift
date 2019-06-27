//
//  CitiesContract.swift
//  Weather
//
//  Created by Juliano Tarini on 22/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import Foundation

protocol CitiesView: class {
  
  var presenter: CitiesPresenter! { get set }
  
  func reloadCities(_ cities: [City])
  func showEmptyView()
  func showError(_ error: Error)
  
}

protocol CitiesPresenter {
  
  var view: CitiesView! { get set }
  
  func fetchData(_ cityIds: [String], actualLocation: [String: Double]?)
  
}
