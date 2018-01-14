//
//  StationData.swift
//  Air Pollution
//
//  Created by Karol Ch on 12/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

struct StationData: Decodable {
    let id: Int
    let stCalcDate: String
    let stIndexLevel: StationIndexLevel?
}
