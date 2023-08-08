//
//  PublicacoesViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 07/08/23.
//

import UIKit

class PublicacoesViewController: UIViewController {
    @IBOutlet var pvTipoPublicacao: UIPickerView!
    @IBOutlet var tvPublicacao: UITableView!
    @IBOutlet var pvAreaAtuacao: UIPickerView!
    @IBOutlet var aiLoading: UIActivityIndicatorView!
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    var publicacoes: [PublicacaoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvPublicacao.dataSource = self
        self.tvPublicacao.delegate = self
        
        DispatchQueue.main.async {
            self.aivLoading.startAnimating()
        }
        // Recupera publicacoes com parametros default
        Rest.loadPublicacoes(onComplete: { (publicacoesFromRest) in
            self.publicacoes = publicacoesFromRest
            DispatchQueue.main.async {
                self.tvPublicacao.reloadData()
                self.aivLoading.stopAnimating()
            }
        }, onError: { restError in
            print(restError)
            DispatchQueue.main.async {
               self.aivLoading.stopAnimating()
            }
        }, tipoPublicacao: "")

    }
}


extension PublicacoesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicacoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPublicacao.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PublicacaoTableViewCell
        
        cell.Prepare(with: publicacoes[indexPath.row])
       
        return cell
    }
}
