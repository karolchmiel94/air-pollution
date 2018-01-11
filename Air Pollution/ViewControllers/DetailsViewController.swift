//
//  DetailsViewController.swift
//  Air Pollution
//
//  Created by Karol Ch on 09/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var stationSensors = [StationSensors]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        for itemName in stationSensors {
            print(itemName.param.paramName)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
