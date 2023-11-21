//
//  PublicacoesViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 07/08/23.
//

import UIKit

class PublicacoesViewController: UIViewController {
    @IBOutlet var tvPublicacao: UITableView!
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    @IBOutlet var popupButtonTiupoPublicacao: UIButton!
    var publicacoes: [PublicacaoItem] = []
    private var viewModel = PublicacaoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // associa a viewmodel
        setupBind()
        // configura os filtros
        setupPopUpButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // recupera publicacoes
        showItens()
    }
        
    private func setupBind(){
        viewModel.showLoading = { [weak self] in
            DispatchQueue.main.async {
                self?.aivLoading.startAnimating()
            }
        }
        
        viewModel.hideLoading = {[weak self] in
            DispatchQueue.main.async {
                self?.aivLoading.stopAnimating()
            }
        }
        
        viewModel.showItens = { [weak self] itens in
            self?.publicacoes = itens
            DispatchQueue.main.async {
                self?.tvPublicacao.reloadData()
                self?.aivLoading.stopAnimating()
            }
        }
        
        viewModel.clearTable = { [weak self] in
            self?.publicacoes = []
            DispatchQueue.main.async {
                self?.tvPublicacao.reloadData()
                self?.aivLoading.stopAnimating()
            }
        }
        
        viewModel.showErrorMessage = { [weak self] erro in
            self?.publicacoes = []
            DispatchQueue.main.async {
                self?.tvPublicacao.reloadData()
                self?.aivLoading.stopAnimating()
                print(erro)
                let alert = UIAlertController(title: "Alert", message: "Erro ao recuperar dados do site MPT. Aguarde um momento e selecione novamente um tipo de publicação para exibir.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
            print(erro)
        }
        
    }
    
    private func showItens(){
        // configura filtros selecionados na view
        let filter = popupButtonTiupoPublicacao.menu?.selectedElements[0].title ?? ""
        // recupera publicacoes do site
        viewModel.getBooks(filter: filter)
    }
    
    private func setupPopUpButtons(){
              
        let popUpButtonClosure = { (action: UIAction) in
            self.showItens()
        }
        
        popupButtonTiupoPublicacao.menu = UIMenu(children: [
            UIAction(title: "Artigos",handler: popUpButtonClosure),
            UIAction(title: "Cartilhas",handler: popUpButtonClosure),
            UIAction(title: "Estudos",handler: popUpButtonClosure),
            UIAction(title: "Livros",handler: popUpButtonClosure),
            UIAction(title: "Manuais",handler: popUpButtonClosure),
            UIAction(title: "Revista Labor",handler: popUpButtonClosure),
        ])
        popupButtonTiupoPublicacao.showsMenuAsPrimaryAction = true
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // recupera proximo viewControler
        let vc = segue.destination as! PublicacoesDetailViewController
        let publicacao = publicacoes[tvPublicacao.indexPathForSelectedRow!.row]
        vc.publicacaoItem = publicacao
    }
    
}

extension PublicacoesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return publicacoes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvPublicacao.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PublicacaoTableViewCell
        cell.Prepare(with: publicacoes[indexPath.row] )
        return cell
    }
}

