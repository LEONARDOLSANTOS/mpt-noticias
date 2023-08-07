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
    @IBOutlet var lbResume: UILabel!
    @IBOutlet var tvBody: UITextView!
    // testar com web view
    
    
    var new: NewsItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("titulo da noticia \(new.title)")
        // Do any additional setup after loading the view.
        config()
    }
    
    @IBAction func shareNews(_ sender: Any) {
        
        let items = ["Acompanhe esta notícia no site do MPT:\n\(new.title)", new.id]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
        
    }
    func config(){
        lbTitle.text = new.title
        lbInfo.text = new.description
        lbResume.text = formatDate(ploneDate: new.effective)  + formatSubjects(ploneSubjects: new.subjects)
        tvBody.attributedText = new.text.data.htmlToAttibutedString
        tvBody.font = UIFont(name: tvBody.font?.fontName ?? "System", size: 20)
        
        
        //new.body.htmlToAttibutedString
        //ivNew.image = new.image
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
