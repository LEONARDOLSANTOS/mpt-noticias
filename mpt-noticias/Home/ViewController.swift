//
//  ViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tfFilter: UITextField!
    @IBOutlet var tvNews: UITableView!
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    var newsItem: [NewsItem] = []
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Exibe VIEW com  termos de uso do app
        showTermsUse()
        // associa a viewmodel
        setupBind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // recupera noticias para exibicao
        viewModel.getNews()
    }
    
    private func setupBind(){
        
        viewModel.showLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.aivLoading.startAnimating()
            }
        }
        viewModel.hideLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.aivLoading.stopAnimating()
            }
        }
        viewModel.showItens = { [weak self] itens in
            self?.newsItem = itens
            DispatchQueue.main.async {
                self?.tvNews.reloadData()
                self?.aivLoading.stopAnimating()
                self?.tfFilter.endEditing(true)
            }
        }
        viewModel.clearTable = { [weak self] in
            self?.newsItem = []
            DispatchQueue.main.async {
                self?.tvNews.reloadData()
                self?.aivLoading.stopAnimating()
                self?.tfFilter.endEditing(true)
            }
        }
        viewModel.showErrorMessage = { [weak self] erro in
            self?.newsItem = []
            DispatchQueue.main.async {
                self?.tvNews.reloadData()
                self?.aivLoading.stopAnimating()
                self?.tfFilter.endEditing(true)
                let alert = UIAlertController(title: "Alert", message: "Erro ao recuperar dados do site MPT. Agurade um momento e click em BUSCAR", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            print(erro)
        }
    }
  
    // açao do botao filtrar/buscar
    @IBAction func buscarNoticias(_ sender: Any) {
        
        viewModel.getNews(filter: tfFilter.text ?? "")
        
    }
    
    // configura parametros tela de detalhamento
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NewsDetailViewController
        let destaque = newsItem[tvNews.indexPathForSelectedRow!.row]
        vc.new = destaque
    }
    
    func showTermsUse() {
        // recupera configuraçoes do usuario
        let config = Configuration.shared
        
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

extension ViewController: UITextFieldDelegate{
    // recupera novos itens ao limpar campo de filtro
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        viewModel.getNews()
        return true
      }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        cell.Prepare(with: newsItem[indexPath.row] )
        return cell
    }
}
