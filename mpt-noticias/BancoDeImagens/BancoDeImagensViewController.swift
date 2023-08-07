//
//  BancoDeImagensViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 05/08/23.
//

import UIKit

class BancoDeImagensViewController: UIViewController {
   
    @IBOutlet var tableViewImagens: UITableView!
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    var imagens : [ImagemItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableViewImagens.dataSource = self
        self.tableViewImagens.delegate = self
        
        DispatchQueue.main.async {
            self.aivLoading.startAnimating()
        }
    
        Rest.loadImagens { (imagensFromRest) in
            self.imagens = imagensFromRest
            DispatchQueue.main.async {
                self.tableViewImagens.reloadData()
                self.aivLoading.stopAnimating()
            }
        } onError: { restError in
            print(restError)
            DispatchQueue.main.async {
               self.aivLoading.stopAnimating()
            }
        }
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

extension BancoDeImagensViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewImagens.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImagensTableViewCell
        
        cell.Prepare(with: imagens[indexPath.row])
       
        return cell
    }
}
