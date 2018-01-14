//
//  SensorTableViewCell.swift
//  Air Pollution
//
//  Created by Karol Ch on 12/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

class SensorTableViewCell: UITableViewCell {

    @IBOutlet weak var sensorNameLabel: UILabel!
    @IBOutlet weak var sensorDataView: UIView!
    @IBOutlet weak var sensorDataLabel: UILabel!
    @IBOutlet weak var sensorDataViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sensorDataActivityIndicator: UIActivityIndicatorView!
    var isLoading = false
    var hasData = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if isLoading {
            sensorDataActivityIndicator.startAnimating()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func set(content: SensorTableViewCellContent) {
        self.sensorNameLabel.text = content.title;
        self.sensorDataLabel.text = content.subtitle
        self.sensorDataViewHeight.constant = content.expanded ? 129 : 0
        if content.hasData {
            self.sensorDataLabel.isHidden = false
        }
    }
}
