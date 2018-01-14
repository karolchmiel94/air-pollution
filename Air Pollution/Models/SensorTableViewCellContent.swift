//
//  SensorTableViewCellContent.swift
//  Air Pollution
//
//  Created by Karol Ch on 12/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

class SensorTableViewCellContent {
    var title: String?
    var subtitle: String?
    var expanded: Bool
    var isLoading: Bool
    var sensorInfo: StationSensors
    var hasData: Bool
    
    init(with title: String, subtitle: String, sensor: StationSensors) {
        self.title = title
        self.subtitle = subtitle
        self.expanded = false
        self.isLoading = false
        self.sensorInfo = sensor
        self.hasData = false
    }
}
