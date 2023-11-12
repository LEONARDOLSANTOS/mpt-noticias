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
    var publicacoes: [PublicacaoItem] = []
    private var viewModel = PublicacaoViewModel()

    
    @IBOutlet var popupButtonTiupoPublicacao: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPopUpButtons()
        
        setupBind()
        
        showItens()

    }
    
    func setupPopUpButtons(){
              
        let popUpButtonClosure = { (action: UIAction) in
                        self.showItens()
        }
        
        popupButtonTiupoPublicacao.menu = UIMenu(children: [
            UIAction(title: "Artigos",handler: popUpButtonClosure),
            UIAction(title: "Cartilhas",handler: popUpButtonClosure),
//            UIAction(title: "Estudos",handler: popUpButtonClosure),
            UIAction(title: "Livros",handler: popUpButtonClosure),
            UIAction(title: "Manuais",handler: popUpButtonClosure),
            //UIAction(title: "Mpt na Escola",handler: popUpButtonClosure),
            //UIAction(title: "Notas Técnicas",handler: popUpButtonClosure),
            //UIAction(title: "Orientações",handler: popUpButtonClosure),
            UIAction(title: "Revista Labor",handler: popUpButtonClosure),
        ])
        popupButtonTiupoPublicacao.showsMenuAsPrimaryAction = true
        
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
                self?.aivLoading.stopAnimating()
                self?.tvPublicacao.reloadData()
               
            }
        }
        
        viewModel.clearTable = { [weak self] in
            self?.publicacoes = []
            DispatchQueue.main.async {
                self?.tvPublicacao.reloadData()
                self?.aivLoading.stopAnimating()
            }
        }
    }
    
    private func showItens(){
        
        let filtros = formatFiltros()
        viewModel.getBooksFromUrl(queryString: filtros)
    }
        
    func formatFiltros() -> String {
        var  queryString  = ""
        queryString += "&tipo_de_publicacao="
        switch popupButtonTiupoPublicacao.menu?.selectedElements[0].title ?? "" {
        case "Artigos":
            queryString += "artigos"
        case "Cartilhas":
            queryString += "cartilhas"
        case "Estudos":
            queryString += "estudos_unicamp"
        case "Livros":
            queryString += "livros"
        case "Manuais":
            queryString += "manuais"
        case "MPT na Escola":
            queryString += "mpt_na_escola"
        case "Notas Técnicas":
            queryString += "notas_tecnicas"
        case "Orientações":
            queryString += "orientacoes"
        case "Revista Labor":
            queryString += "revista_labor"
        default:
            queryString=""
        }
       
       
        
        return queryString
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

