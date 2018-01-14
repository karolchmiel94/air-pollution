//
//  Sensor.swift
//  Air Pollution
//
//  Created by Karol Ch on 13/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Sensor: Decodable {
    var key: String?
    var values: [SensorValues]
    
    init(with key: String, and values: [SensorValues]) {
        self.key = key
        self.values = values
    }
    
    init(with data: Data) {
        let json = JSON(data)
        self.key = json["key"].stringValue
        
        var values = [SensorValues]()
        if let valuesArray = json["values"].array {
            for index in 0...valuesArray.count - 1 {
                let dateString = valuesArray[index]["date"].stringValue
                let valueString = valuesArray[index]["value"].stringValue
                if let date = SensorValues.formatter.date(from: dateString),
                    let value = Double(valueString) {
                    let item = SensorValues(date: date, value: value)
                    values.append(item)
                }
            }
        }
        self.values = values
    }
    
    mutating func initWith(data: Data) {
        let json = JSON(data)
        self.key = json["key"].stringValue
        var values = [SensorValues]()
        
        if let valuesArray = json["values"].array {
            for index in 0...valuesArray.count {
                let dateString = valuesArray[index]["date"].stringValue
                let valueString = valuesArray[index]["value"].stringValue
                let date = SensorValues.formatter.date(from: dateString)
                let item = SensorValues(date: date!, value: Double(valueString)!)
                values.append(item)
            }
        }
        self.values = values
    }
    
    struct SensorValues: Decodable {
        let date: Date
        let value: Double?
        
        init(date: Date, value: Double) {
            self.date = date
            self.value = value
        }
        
        static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.timeZone = nil
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
    }
}
