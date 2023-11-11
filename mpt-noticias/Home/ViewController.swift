//
//  ViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textBuscar: UITextField!
    @IBOutlet var tvNews: UITableView!
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    var destaques: [NewsItem] = []
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Exibe regras de uso do app
        showTermsUse()
        
        // associa a viewmodel
        setupBind()
        
        // recupera noticias para exibicao
        viewModel.getDataFromUrl(queryString: textBuscar.text ?? "")
    }
    
    private func setupBind(){
        viewModel.showLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.aivLoading.startAnimating()
            }
        }
        
        viewModel.showLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.aivLoading.stopAnimating()
            }
        }
        
        viewModel.showItens = { [weak self] itens in
            self?.destaques = itens
            DispatchQueue.main.async {
                self?.tvNews.reloadData()
                self?.aivLoading.stopAnimating()
            }
        }
        viewModel.clearTable = { [weak self] in
            self?.destaques = []
            DispatchQueue.main.async {
                self?.tvNews.reloadData()
                self?.aivLoading.stopAnimating()
            }
        }
        
        
    }
  
    @IBAction func buscarNoticias(_ sender: Any) {
        
        viewModel.getDataFromUrl(queryString: textBuscar.text ?? "")
        
    }
    
    // configura parametros tela de detalhamento
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NewsDetailViewController
        let destaque = destaques[tvNews.indexPathForSelectedRow!.row]
        vc.new = destaque
    }
    
    func showTermsUse() {
        // recupera configuraçoes do usuario
        let config = Configuration.shared
        
        //config.termOfUseAccepted = false
        // se usuario já aceitou termos nao exibe novamente
        if !config.termOfUseAccepted {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "IDTermsOfUseViewController") else {
                    fatalError("Dont find view controller of terms of use")
            }
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destaques.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.Prepare(with: destaques[indexPath.row] )
        return cell
    }
}
