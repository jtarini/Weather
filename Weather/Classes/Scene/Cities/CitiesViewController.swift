//
//  CitiesViewController.swift
//  Weather
//
//  Created by Juliano Tarini on 22/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import UIKit
import SVPullToRefresh
import DZNEmptyDataSet
import SkeletonView
import SDWebImage
import CoreLocation

class CitiesViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - Public and internal attributes
  
  var presenter: CitiesPresenter!
  private var cities: [City]!
  private let locationManager = CLLocationManager()
  private var actualLocation: CLLocation!

  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeView()
    
    if CLLocationManager.authorizationStatus() != .denied {
      initializeLocationManager()
    }
    else {
      fetchCities()
    }
  }
  
  // MARK: - Internal functions
  
  /**
   Initialize and customize the UI elements.
  */
  fileprivate func initializeView() {
    navigationController?.navigationBar.topItem?.title = NSLocalizedString("cities", value: "", comment: "")
    
    tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: "CityTableViewCell")
    tableView.tableFooterView = UIView(frame: CGRect.zero)
    tableView.cellLayoutMarginsFollowReadableWidth = false
    
    tableView.addPullToRefresh(actionHandler: {() -> Void in
      self.fetchCities()
    })
    
    tableView.pullToRefreshView.titleLabel.font = UIFont(name: "Avenir-Medium", size: 12)
    tableView.pullToRefreshView.arrowColor = UIColor(red: 35 / 255, green: 118 / 255, blue: 172 / 255, alpha: 1.0)
  }
  
  /**
   Fetch cities data.
  */
  fileprivate func fetchCities() {
    let londonId = "2643743"
    let tokyoId = "1850147"
    
    var cityIds = [String]()
    cityIds.append(londonId)
    cityIds.append(tokyoId)
    
    var location = [String: Double]()
    if let actualLocationObj = actualLocation {
      location["latitude"] = actualLocationObj.coordinate.latitude
      location["longitude"] = actualLocationObj.coordinate.longitude
    }
    
    presenter.fetchData(cityIds, actualLocation: location)
  }
  
  /**
   Initialize the location manager.
  */
  fileprivate func initializeLocationManager() {
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    locationManager.startUpdatingLocation()
  }
  
}

extension CitiesViewController: CitiesView {
  
  func reloadCities(_ cities: [City]) {
    self.cities = cities
    
    tableView.reloadData()
    
    tableView.pullToRefreshView.stopAnimating()
  }
  
  func showEmptyView() {
    cities = []
    
    tableView.contentOffset = CGPoint.zero
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
    
    tableView.reloadData()
    
    tableView.pullToRefreshView.stopAnimating()
  }
  
  func showError(_ error: Error) {
    let alert = UIAlertController(title: NSLocalizedString("general.error.message.title", value: "", comment: ""), message: error.localizedDescription, preferredStyle: .alert)
    let ok = UIAlertAction(title: NSLocalizedString("ok", value: "", comment: ""), style: .default, handler: { (action) -> Void in
      alert.dismiss(animated: true, completion: nil)
    })
    alert.addAction(ok)
    
    present(alert, animated: true, completion: nil)
  }
  
}

extension CitiesViewController: SkeletonTableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let items = cities else {
      return 3
    }
    
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as! CityTableViewCell
    
    guard let items = cities else {
      return cell
    }
    
    cell.hideSkeleton()
    
    let city = items[indexPath.row]
    cell.name.text = city.cityWithCountry
    cell.temperature.text = city.temperatureWithDegrees
    
    cell.weatherIcon.sd_setImage(with: city.weatherIconUrl, placeholderImage: UIImage(named: "img-placeholder"))
    
    return cell
  }
  
  func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
    return "CityTableViewCell"
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let city = cities![indexPath.row]
    
    let cityViewController = storyboard?.instantiateViewController(withIdentifier: "CityViewController") as! CityViewController
    cityViewController.city = city
    
    navigationController?.show(cityViewController, sender: self)
  }
  
}

extension CitiesViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if actualLocation == nil {
      actualLocation = locations.last
      
      fetchCities()
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .denied {
      fetchCities()
    }
  }
  
}

extension CitiesViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
  
  func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
    return UIImage(named: "empty-results")
  }
  
  func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
    return NSAttributedString(string: NSLocalizedString("empty.cities.message", value: "", comment: ""), attributes: [NSAttributedString.Key.font: UIFont(name: "Avenir-Medium", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.black])
  }
  
  func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
    return true
  }
  
}
