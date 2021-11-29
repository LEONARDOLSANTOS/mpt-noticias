//
//  NewsTableViewCell.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 29/11/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var ivNoticia: UIImageView!
    @IBOutlet var lbTitulo: UILabel!
    @IBOutlet var lbInfo: UILabel!
    @IBOutlet var lbDescricao: UILabel!
    
    func setNew(with new: Noticia){
        self.lbTitulo.text = new.titulo
        self.lbInfo.text = new.info
        self.lbDescricao.text = new.resumo
        self.ivNoticia.image = new.image
        
    }
    
}
