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
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    var publicacoes = [PublicacaoItem] (){
        didSet{
            DispatchQueue.main.async {
                self.tvPublicacao.reloadData()
            }
        }
    }
    var tiposDePublicacao: [String] = [String]()
    var areasDeAtuacao: [String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pvTipoPublicacao.delegate = self
        pvTipoPublicacao.dataSource = self

        
        tiposDePublicacao = ["Artigos","Cartilhas","Estudos","Livros", "Manuais", "MPT na Escola", "Nota Técnica", "Orientações", "Revista Labor"]
        areasDeAtuacao = ["Administração Pública","Criança e Adolescente", "Fraudes Trabalhistas", "Liberdade Sindical", "Meio Ambiente do Trabalho","Promoção da Igualdade", "Trabalho Portuário e Aquaviário", "Trabalho Escravo"]
        
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


extension PublicacoesViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return tiposDePublicacao.count
        } else{
            return areasDeAtuacao.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return tiposDePublicacao[row]
        } else{
            return areasDeAtuacao[row]
        }
    }
}
