//
//  StationSensors.swift
//  Air Pollution
//
//  Created by Karol Ch on 08/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

struct StationSensors: Decodable {
    let id: Int
    let stationId: Int
    let param: StationSensorParams
}
