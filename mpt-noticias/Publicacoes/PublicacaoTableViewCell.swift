//
//  PublicacaoTableViewCell.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 08/08/23.
//

import UIKit

class PublicacaoTableViewCell: UITableViewCell {

    @IBOutlet var ivPublicacao: UIImageView!
    @IBOutlet var labelTitulo: UITextView!
   
    
    @IBOutlet var labelTag: UILabel!
    
    func Prepare(with item: PublicacaoItem){
        self.labelTitulo.text = item.title
        if item.image.download != "" {
            let url = URL(string: item.image.scales.mini.download)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async{
                        self.ivPublicacao.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
