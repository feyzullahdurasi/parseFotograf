//
//  FeedTableViewCell.swift
//  parseFotograf
//
//  Created by Feyzullah Durası on 20.05.2024.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var kullaniciAdiLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var kullaniciYorumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
