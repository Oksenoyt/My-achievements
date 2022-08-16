//
//  CountriesViewController.swift
//  My achievements
//
//  Created by Elenka on 16.08.2022.
//

import UIKit
import Alamofire

class CountriesViewController: UITableViewController {
    private let link = "https://restcountries.com/v2/all"
    
    private var countriesDataDD: [Country] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 300
        
        fetchData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesDataDD.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        else {
            return UITableViewCell()
        }
        let country = countriesDataDD[indexPath.row]
        cell.configure(with: country)
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    private func fetchData() {
        AF.request(link)
            .validate()
            .responseJSON { [weak self] dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let countriesData = value as? [[String: Any]] else { return }
                    for countryData in countriesData {
                        let country = Country(
                            name: countryData["name"] as? String ?? "no name",
                            capital: countryData["capital"] as? String ?? "no capital",
                            region: countryData["region"] as? String ?? "no region",
                            subregion: countryData["subregion"] as? String ?? "no subregion",
                            flag: countryData["flag"] as? String ?? "no flag",
                            population: countryData["population"] as? Int ?? 0
                        )
                        self?.countriesDataDD.append(country)
                    }
                    print("massive", self?.countriesDataDD)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
