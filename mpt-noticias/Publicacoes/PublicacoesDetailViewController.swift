//
//  PublicacoesDetailViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 10/08/23.
//

import UIKit
import WebKit

class PublicacoesDetailViewController: UIViewController {

    @IBOutlet var wkPublicacao: WKWebView!
    
    var publicacaoItem : PublicacaoItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   configWebView()
        
        configWebViewFromURL(urlString: publicacaoItem.arquivoPDF.download )
    }
    
    func configWebView(){
        let path = Bundle.main.path(forResource: "arquivo_pdf", ofType: "pdf")
        let url = URL(fileURLWithPath: path!)
        let request = URLRequest(url: url)
        wkPublicacao.load(request)
    }
    
    func configWebViewFromURL(urlString : String){
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        wkPublicacao.load(request)
    }
    
    
    func config(){
        print(publicacaoItem.arquivoPDF.download)
        let urlForDownload : String = publicacaoItem.arquivoPDF.download
        if (urlForDownload.contains("@@download") ){
            
        }
        
            
            
        
       // let fileURL = URL(fileURLWithPath: publicacaoItem.arquivoPDF.download )
        //print(fileURL)
        loadPdf(urlString: "https://mpt.mp.br/pgt/publicacoes/artigos/revista-do-tribunal-superior-do-trabalho-ano-88-no-3-de-julho-a-setembro-de-2022/@@display-file/arquivo_pdf")
        //wkPublicacao.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
    }
    
    func loadPdf(urlString: String) {
            let fileURL = URL(fileURLWithPath: urlString )
            if let pdfUrl = Bundle.main.url(forResource: urlString, withExtension: "pdf", subdirectory: nil, localization: nil) {

                do {
                    let data = try Data(contentsOf: pdfUrl)
                    wkPublicacao.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfUrl.deletingLastPathComponent())
                    print("pdf file loading...")
                }
                catch {
                    print("failed to open pdf")
                }
                return
            }

            print("pdf file doesn't exist")
        }

}
