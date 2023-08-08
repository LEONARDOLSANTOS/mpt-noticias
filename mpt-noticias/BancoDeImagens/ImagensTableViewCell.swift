//
//  ImagensTableViewCell.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 05/08/23.
//

import UIKit

class ImagensTableViewCell: UITableViewCell {

    @IBOutlet var ivNoticia: UIImageView!
    @IBOutlet var labelTitulo: UILabel!
    

    func Prepare(with imagem: ImagemItem){
        self.labelTitulo.text = imagem.title
        if imagem.image.download != "" {
            let url = URL(string: imagem.image.scales.mini.download)
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async{
                        self.ivNoticia.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
