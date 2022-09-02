//
//  CountriesViewController.swift
//  My achievements
//
//  Created by Elenka on 16.08.2022.
//

import UIKit

class CountriesViewController: UITableViewController {
//    другая апи
//    private let link = "https://countriesnow.space/api/v0.1/countries"
//    private let link = "https://documenter.getpostman.com/view/1134062/T1LJjU52#aba28957-5149-46e1-8a68-8021a6f5f30c"
    
    private let link = "https://restcountries.com/v2/all"
    
    private var countries: [Country] = []
    private var regions: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 70
        fetchData(from: link)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        getRegion(from: countries)
        print("regions.count",regions.count)
        return regions.count
//        3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sdfd = regions[section]
        print("section name", sdfd)
        return sdfd
//        "qweqwe"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell
        else {
            return UITableViewCell()
        }
        
        let region1 = regions[indexPath.section]
        let country = countries[indexPath.row]
        if country.region.contains(region1){
            cell.configure(with: country)
        }
        
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
    
    // MARK: - Private methods
    private func getRegion(from countries: [Country]) {
        for country in countries {
            let region = country.region
            if !regions.contains(region) {
                regions.append(region)
            }
        }
        print(regions)
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.countries = value
                self?.tableView.reloadData()
//                self?.getRegion(from: self?.countries ?? [])
            case .failure(let error):
                print(error)
            }
        }

    }
    
    
}
