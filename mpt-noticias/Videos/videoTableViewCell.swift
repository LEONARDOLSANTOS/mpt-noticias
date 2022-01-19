//
//  videoTableViewCell.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 19/01/22.
//

import UIKit

class videoTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var ivVideo: UIImageView!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
        
    // MARK: - Constants and Variables
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
