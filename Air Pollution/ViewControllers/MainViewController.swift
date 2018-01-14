//
//  ViewController.swift
//  Air Pollution
//
//  Created by Karol Ch on 06/01/2018.
//  Copyright © 2018 Karol Chmiel. All rights reserved.
//

import UIKit
import Gifu
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var searchResultsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var button: UIButton!
    var stations = [Station]()
    var filteredData: [Station]!
    var stationSensors = [StationSensors]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadStations()
        filteredData = stations
    }
    
    func downloadStations() {
        guard let url = URL(string: "http://api.gios.gov.pl/pjp-api/rest/station/findAll") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                return
            }
            guard let data = data else { return }
            
            do {
                self.stations = try JSONDecoder().decode([Station].self, from: data)
            } catch let error {
                print(error)
            }
            
            }.resume()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let screenSize = UIScreen.main.bounds
        let gifView = GIFImageView(frame: screenSize)
        self.view.addSubview(gifView)
        self.view.sendSubview(toBack: gifView)
        gifView.animate(withGIFNamed: "main_screen_gif")
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
//        searchBar.layer.cornerRadius = 12
//        searchBar.layer.masksToBounds = true
        searchBar.barTintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        searchBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        searchResultsTableView.layer.cornerRadius = 12
        searchResultsTableView.layer.masksToBounds = true
        searchResultsTableView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        searchResultsTableView.reloadData()
        searchResultsTableView.tableFooterView = UIView(frame: .zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

extension MainViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath)
        cell.textLabel?.text = filteredData[indexPath.row].stationName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let station = filteredData[indexPath.row] as? Station else {
            return
        }
        guard let url = URL(string: "http://api.gios.gov.pl/pjp-api/rest/station/sensors/\(station.id)") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                return
            }
            guard let data = data else { return }
            
            do {
                self.stationSensors = try JSONDecoder().decode([StationSensors].self, from: data)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                vc.stationSensors = self.stationSensors
                vc.stationId = station.id
                OperationQueue.main.addOperation {
                    self.present(vc, animated: true, completion: nil)
                }
//                self.performSegue(withIdentifier: "DetailsViewController", sender: nil)
                
            } catch let error {
                print(error)
            }
            
            }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController" {
            if let detailsVC = segue.destination as? DetailsViewController {
                detailsVC.stationSensors = self.stationSensors
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? stations : stations.filter({ (item: Station) -> Bool in
            return item.stationName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        if filteredData.count < 3 {
            let difference = 3 - filteredData.count
            searchResultsTableHeight.constant = CGFloat(188 - (44 * difference))
        } else {
            searchResultsTableHeight.constant = 188
        }
        searchResultsTableView.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.searchBar.showsCancelButton = true
    }
    
}
