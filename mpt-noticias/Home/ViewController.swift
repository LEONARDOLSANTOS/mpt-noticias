//
//  ViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tvNews: UITableView!
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    var destaques: [NewsItem] = []
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let config = Configuration.shared
        //config.termOfUseAccepted = false
        if !config.termOfUseAccepted {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "IDTermsOfUseViewController") else {
                    fatalError("Dont find view controller of terms of use")
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        DispatchQueue.main.async {
            self.aivLoading.startAnimating()
        }
     
        Rest.loadDestaques { (ItemsFromRest) in
            self.destaques = ItemsFromRest
            // necessario para atualizar tableView
            DispatchQueue.main.async {
                self.tvNews.reloadData()
                self.aivLoading.stopAnimating()
            }
        } onError: { erro in
            print(erro)
            DispatchQueue.main.async {
               self.aivLoading.stopAnimating()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // recupera proximo viewControler
        let vc = segue.destination as! NewsDetailViewController
        let destaque = destaques[tvNews.indexPathForSelectedRow!.row]
        vc.new = destaque
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destaques.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.Prepare(with: destaques[indexPath.row])
       
        return cell
    }
}
