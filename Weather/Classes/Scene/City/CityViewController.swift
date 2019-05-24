//
//  CityViewController.swift
//  Weather
//
//  Created by Juliano Tarini on 22/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
  
  // MARK: - Outlets
  
  @IBOutlet weak var windLabelTitle: UILabel!
  @IBOutlet weak var windLabelValue: UILabel!
  @IBOutlet weak var cloudLabelTitle: UILabel!
  @IBOutlet weak var cloudLabelValue: UILabel!
  
  // MARK: - Public and internal attributes
  
  var city: City!
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initializeView()
  }
  
  // MARK: - Internal functions
  
  /**
   Initialize and customize the UI elements.
  */
  fileprivate func initializeView() {
    title = "\(NSLocalizedString("weather.in", value: "", comment: "")) \(city.cityWithCountry)"
    
    let backButton = UIBarButtonItem(image: UIImage(named: "back-white"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(CityViewController.back))
    navigationItem.leftBarButtonItem = backButton
    
    windLabelTitle.text = NSLocalizedString("wind.speed", value: "", comment: "")
    cloudLabelTitle.text = NSLocalizedString("clouds", value: "", comment: "")
    
    windLabelValue.text = city.windSpeed
    cloudLabelValue.text = city.cloudsPercent
    
    let rightRecognizer = UISwipeGestureRecognizer(target: self, action:
      #selector(swipeMade(_:)))
    rightRecognizer.direction = .right
    view.addGestureRecognizer(rightRecognizer)
  }
  
  /**
   Detects swipe move from left to right and goes back to list of cities screen.
  */
  @IBAction func swipeMade(_ sender: UISwipeGestureRecognizer) {
    if sender.direction == .right {
      back()
    }
  }
  
  /**
   Back to list of cities.
  */
  @objc func back() {
    _ = navigationController?.popViewController(animated: true)
  }
  
}
