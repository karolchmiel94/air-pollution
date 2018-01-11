//
//  Station.swift
//  Air Pollution
//
//  Created by Karol Ch on 07/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

struct Station: Decodable {
    let id: Int
    let stationName: String
    let gegrLat: String
    let gegrLon: String
    let city: City?
    let addressStreet: String?
}
