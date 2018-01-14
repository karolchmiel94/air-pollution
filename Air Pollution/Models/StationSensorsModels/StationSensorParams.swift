//
//  Params.swift
//  Air Pollution
//
//  Created by Karol Ch on 08/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

struct StationSensorParams: Decodable {
    let paramName: String
    let paramFormula: String
    let paramCode: String
    let idParam: Int
}
