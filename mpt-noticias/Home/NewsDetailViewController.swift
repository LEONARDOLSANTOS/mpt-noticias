//
//  NewsDetailViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 29/11/21.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbInfo: UILabel!
    @IBOutlet var ivNew: UIImageView!
    @IBOutlet var lbResume: UILabel!
    @IBOutlet var lbBody: UILabel!
    var new: Noticia!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("titulo da noticia \(new.titulo)")
        // Do any additional setup after loading the view.
        
        config()
    }
    
    func config(){
        lbTitle.text = new.titulo
        lbInfo.text = new.info
        lbResume.text = new.resumo
        lbBody.attributedText = new.body.htmlToAttibutedString
        ivNew.image = new.image
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

extension String
{
    var htmlToAttibutedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else {return nil}
        do{
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch{
            return nil
        }
    }
}
