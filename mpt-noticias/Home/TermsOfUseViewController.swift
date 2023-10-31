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

        configLayout()
    }
    
    func configLayout(){
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func agreeWithTerms(_ sender: Any) {
        let config = Configuration.shared
        print("Aceitou o termo de uso ? \(config.termOfUseAccepted)")
        config.termOfUseAccepted = true // todo: essa linha será
        print("Situacao atual(termOfUseAccepted) => \(config.termOfUseAccepted)")
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
