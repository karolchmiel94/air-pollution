//
//  City.swift
//  Air Pollution
//
//  Created by Karol Ch on 07/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

struct City: Decodable {
    let id: Int
    let name: String
    let commune: Commune
}
