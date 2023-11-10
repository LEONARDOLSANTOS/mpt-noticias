//
//  TermsOfUseViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import UIKit

class TermsOfUseViewController: UIViewController {

    @IBOutlet var lbTerms: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func agreeWithTerms(_ sender: Any) {
        let config = Configuration.shared
        print("Aceitou o termo de uso ? \(config.termOfUseAccepted)")
        config.termOfUseAccepted = true 
        print("Situacao atual(termOfUseAccepted) => \(config.termOfUseAccepted)")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
