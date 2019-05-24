//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Juliano Tarini on 22/05/19.
//  Copyright © 2019 jtarini. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var temperature: UILabel!
  @IBOutlet weak var weatherIcon: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    showAnimatedSkeleton()
  }
  
}
