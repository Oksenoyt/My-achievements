//
//  CountryCell.swift
//  My achievements
//
//  Created by Elenka on 16.08.2022.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var checkEmptyButton: UIButton!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    
    private var visited = false
    private var currentCountry = ""
    
    private var imageURL: URL? {
        didSet {
            flagImage.image = nil
            updateImg()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator = showSpinner(in: flagImage)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func checkButton(_ sender: Any) {
        if visited {
            checkButton.isHidden = true
            checkEmptyButton.isHidden = false
        } else {
            checkButton.isHidden = false
            checkEmptyButton.isHidden = true
        }
        visited.toggle()
        StorageManager.shared.update(country: currentCountry, visitedChange: visited)
    }
    
    func configure(with country: Country) {
        nameLabel.text = country.name
        descriptionLabel.text = country.nativeName
        imageURL = URL(string: "https://countryflagsapi.com/png/\(country.alpha2Code)")
        StorageManager.shared.create(country: country.name)
        
        fetchDataFromBD(country: country.name)
        currentCountry = country.name
    }
    
    private func updateImg() {
        guard let url = imageURL else { return  }
        NetworkManager.shared.fetchImg(from: url) { [weak self] result in
            switch result {
            case .success(let value):
                self?.flagImage.image = value
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchDataFromBD(country: String) {
//        StorageManager.shared.fetchData(currentCountry: country) { result in
//            switch result {
//            case .success(let value):
//                visited = value.last?.visitedData ?? false
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
