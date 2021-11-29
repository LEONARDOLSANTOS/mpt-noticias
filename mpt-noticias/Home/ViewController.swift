//
//  ViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tvNews: UITableView!
    var news: [Noticias] = []
    
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
        
        news = getAllNews()
        
    }
    
    func getAllNews() -> [Noticias]{
        var fakenews: [Noticias] = []
        fakenews.append(Noticias(titulo: "Eternit e Sama são obrigadas a realizar exames médicos de controle em ex-empregados", resumo: "Trabalhadores tiveram contato com o amianto, que pode causar doenças respiratórias graves e até câncer", body: "aqiu vai o <strong>html</strong> ", info: "Meio Ambiente do Trabalho - Ontem"))
        fakenews.append(Noticias(titulo: "Trabalho em frigoríficos: audiências públicas no PR e SC discutem revisão da NR 36", resumo: "Eliminação de pausas ameaça segurança de mais de 550 mil empregados do setor no Brasil", body: "aqiu vai o <strong>html</strong> ", info: "Trabalho escravo - Hoje"))
        return fakenews
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.setNew(with: news[indexPath.row])
       
        return cell
    }
    
    
    
}
