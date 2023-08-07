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
    
    func Prepare(with new: NewsItem){
        self.lbTitulo.text = new.title
        self.lbInfo.text = #"\#(formatDate(ploneDate: new.effective))  \#( formatSubjects(ploneSubjects: new.subjects) ) "#
        self.lbDescricao.text = new.description
        print(formatDate(ploneDate: new.effective))
        //self.ivNoticia.image = new.image
    }
    
}

