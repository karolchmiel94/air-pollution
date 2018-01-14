//
//  SensorValues.swift
//  Air Pollution
//
//  Created by Karol Ch on 13/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

struct SensorValuesButOldOne: Codable {
    let date: Date?
    let value: String
    
    init(date: Date, value: String) {
        self.date = date
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try values.decode(Date.self, forKey: .date)
//        guard let sensorValue = try Double(values.decode(String.self, forKey: .value)) else {
//            throw DecodingError.dataCorrupted(.init(codingPath: [CodingKeys.value], debugDescription: "Expecting string representation of Float"))
//        }
//        self.value = sensorValue
        self.value = try values.decode(String.self, forKey: .value)
    }
    
    private enum CodingKeys: String, CodingKey {
        case date, value
    }
}
