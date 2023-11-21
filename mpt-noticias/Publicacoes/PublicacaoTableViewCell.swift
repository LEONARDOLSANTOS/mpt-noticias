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
  
    func Prepare(with item: PublicacaoItem){
        self.labelTitulo.text = item.title
        
        let url = URL(string: item.image?.scales.mini.download ?? "https://mpt.mp.br/++theme++mpt/images/publicacao.png")

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!){
                DispatchQueue.main.async{
                    self.ivPublicacao.image = UIImage(data: data)
                }
            }
        }
        
    }
    
    func setImageFromStringrURL(stringUrl: String) {
      if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              self.ivPublicacao.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
    
}
