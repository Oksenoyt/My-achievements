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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkButton(_ sender: Any) {
    }
    
    func configure(with country: Country) {
//        flagImage.image = UIImage(data: country.flag)
        nameLabel.text = country.country
        descriptionLabel.text = "qweqwe"
        layer.cornerRadius = 5
    }
}
