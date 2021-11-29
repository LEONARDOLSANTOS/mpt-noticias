//
//  NewsDetailViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 29/11/21.
//

import UIKit

class NewsDetailViewController: UIViewController {

    var new: Noticia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("titulo da noticia \(new.titulo)")
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
