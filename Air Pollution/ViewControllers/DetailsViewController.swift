//
//  DetailsViewController.swift
//  Air Pollution
//
//  Created by Karol Ch on 09/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit
import Gifu
import NVActivityIndicatorView

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var stationDataActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var stationDataLabel: UILabel!
    @IBOutlet weak var stationDataView: UIView!
    
    var stationSensors = [StationSensors]()
    var sensorsData = [Sensor]()
    var stationId = Int()
    var infoText = "Dostępne pomiary:\n"
    var sensorsInfo = [SensorTableViewCellContent]()
    
    @IBOutlet weak var sensorsTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for sensor in stationSensors {
            let title = sensor.param.paramName
            let subtitle = "\(sensor.stationId)" + ": " + sensor.param.paramName + " " + sensor.param.paramFormula
            sensorsInfo.append(SensorTableViewCellContent.init(with: title, subtitle: subtitle, sensor: sensor))
        }
        // Set View to be BEAUTY
        mainView.layer.cornerRadius = 12
        mainView.layer.masksToBounds = true
        mainView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        //
        
        sensorsTableView.estimatedRowHeight = 195
        sensorsTableView.rowHeight = UITableViewAutomaticDimension
        stationDataActivityIndicator.startAnimating()
    }
    
    func refreshTableData() {
        
    }

    override func viewWillAppear(_ animated: Bool) {
        for itemName in stationSensors {
            print(itemName.param.paramName)
        }
        sensorsTableView.tableFooterView = UIView(frame: .zero)
        downloadStationData()
    }
    
    func downloadStationData() {
        guard let url = URL(string: "http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/\(stationId)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                return
            }
            guard let data = data else { return }
            
            do {
                let stationData = try JSONDecoder().decode(StationData.self, from: data)
                
                OperationQueue.main.addOperation {
                    self.stationDataLabel.text = "Stan powietrza: " + (stationData.stIndexLevel?.indexLevelName)!
                    self.stationDataActivityIndicator.isHidden = true
                    self.stationDataLabel.isHidden = false
                }
            } catch let error {
                print(error)
            }
            
            }.resume()
    }
    
    @IBAction func dismissViewAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sensorsInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SensorTableViewCell", for: indexPath) as! SensorTableViewCell
        cell.set(content: sensorsInfo[indexPath.row])
        if cell.isLoading {
            cell.sensorDataActivityIndicator.startAnimating()
        } else {
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = sensorsInfo[indexPath.row]
        content.expanded = !content.expanded
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        let cell = tableView.cellForRow(at: indexPath) as! SensorTableViewCell
        if content.expanded {
            cell.sensorDataActivityIndicator.startAnimating()
            cell.isLoading = true
            downloadSensorData(with: stationSensors[indexPath.row].id, for: indexPath)
        } else {
            cell.sensorDataActivityIndicator.stopAnimating()
            cell.isLoading = false
        }
    }
    
    func downloadSensorData(with id:Int, for cellRow: IndexPath) {
        guard let url = URL(string: "http://api.gios.gov.pl/pjp-api/rest/data/getData/\(id)") else { return }
        print("http://api.gios.gov.pl/pjp-api/rest/data/getData/\(id)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                return
            }
            guard let data = data else { return }
            do {
                let sensorData = Sensor(with: data)
                self.sensorsData.append(sensorData)
                OperationQueue.main.addOperation {
                    self.receivedDataFor(tableViewRow: cellRow)
                }
            }
            }.resume()
        print("Nothing")
    }
    
    func receivedDataFor(tableViewRow: IndexPath) {
        let cell = self.sensorsTableView.cellForRow(at: tableViewRow) as! SensorTableViewCell
        cell.hasData = true
    }
    
}
