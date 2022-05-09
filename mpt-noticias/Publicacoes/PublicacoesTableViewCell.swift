//
//  MyTableViewCell.swift
//  Horizontal Colection View
//
//  Created by Luiz Carlos F Ramos on 14/03/22.
//

import UIKit
class PublicacoesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imageNames = ["a1", "a2", "a3", "a4", "a5"]
    let gameNames  = ["Candy Crush", "Cut the Ropes", "Arbitrary Game 1", "Littlest Pet Shop", "Zuba"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
            // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PublicacoesCollectionViewCell
        cell.imageView.image  = UIImage.init(named: imageNames[indexPath.row])
        cell.titleLabel.text  = gameNames[indexPath.row]
       
        return cell
    }
}
