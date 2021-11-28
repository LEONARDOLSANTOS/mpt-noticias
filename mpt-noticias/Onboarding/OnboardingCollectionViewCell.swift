//
//  OnboardingCollectionViewCell.swift
//  app-ios
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 23/11/21.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self) // utilizado para definir CELL, poderia ser uma string estática
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet var slideDescription: UILabel!
    
    func setup(Com slide: OnboardingSlide){
        slideImageView.image = UIImage(named: slide.image)
        title.text = "Bemvindo ao"
        subTitle.text = slide.title
        slideDescription.text = slide.description
    }
    
}
