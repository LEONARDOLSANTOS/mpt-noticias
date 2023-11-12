//
//  PublicacoesDetailViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 10/08/23.
//

import UIKit
import WebKit

class PublicacoesDetailViewController: UIViewController {

    @IBOutlet var aivLoading: UIActivityIndicatorView!
    @IBOutlet var wkPublicacao: WKWebView!
    
    var publicacaoItem : PublicacaoItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aivLoading.startAnimating()
        configWebViewFromURL(urlString: publicacaoItem.arquivoPDF.download )
        aivLoading.stopAnimating()
    }
    
    func configWebViewFromURL(urlString : String){
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        wkPublicacao.load(request)
    }

}
