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
        fakenews.append(Noticias(titulo: "titulo 1", resumo: "o resumo da noticias", body: "aqiu vai o <strong>html</strong> ", info: "feito ontem - tarde da noite"))
        fakenews.append(Noticias(titulo: "titulo maior", resumo: "o resumo da noticias", body: "aqiu vai o <strong>html</strong> ", info: "feito hoje - depois do almoço"))
        return fakenews
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.lbTitulo?.text = news[indexPath.row].titulo
        //cell.textLabel?.text = news[indexPath.row]
        return cell
    }
    
    
    
}
