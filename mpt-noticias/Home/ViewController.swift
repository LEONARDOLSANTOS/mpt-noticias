//
//  ViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 28/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tvNews: UITableView!
    var news: [Noticia] = []
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! NewsDetailViewController
        let noticia = news[tvNews.indexPathForSelectedRow!.row]
        vc.new = noticia
    }
    
    func getAllNews() -> [Noticia]{
        var fakenews: [Noticia] = []
        fakenews.append(Noticia(titulo: "Eternit e Sama são obrigadas a realizar exames médicos de controle em ex-empregados", resumo: "Trabalhadores tiveram contato com o amianto, que pode causar doenças respiratórias graves e até câncer", body: "<span id='texto-noticia'> <p><strong>Brasília –</strong> O Ministério Público do Trabalho (MPT) firmou acordo de cooperação técnica com o Centro de Excelência contra a Fome do Programa Mundial de Alimentos (WFP) no Brasil para reforçar a erradicação da fome e a promoção da segurança alimentar e nutricional, metas que fazem parte dos Objetivos de Desenvolvimento Sustentável (ODS) da Organização das Nações Unidas (ONU). A assinatura ocorreu no dia 9 de novembro.</p><p>A parceria tem como foco o compartilhamento de boas práticas e o intercâmbio de informações entre o MPT e o Centro de Excelência do WFP em temas como segurança alimentar e nutricional, educação, proteção social, saúde e nutrição.</p><p>A partir do acordo, serão promovidas ações conjuntas que proporcionem a capacitação de gestores e demais envolvidos com essas áreas em conceitos básicos de alimentação adequada e saudável, melhoria dos hábitos alimentares, valorização dos produtos da agricultura familiar da produção à comercialização, aprimoramento na execução do programa de alimentação escolar, combate ao desperdício, entre outros.</p><p>Também está prevista a elaboração de estudos, pesquisas, cursos, oficinas e projetos voltados para educação e saúde, nutrição, segurança alimentar e proteção social bem como a capacitação de docentes e pesquisadores e de estudantes e produção de publicações técnico-científicas sobre esses temas. Todas iniciativas também têm como objetivo o compartilhamento dos conhecimentos e experiências geradas com outros países parceiros, a fim de promover a cooperação internacional.</p></span>", info: "Meio Ambiente do Trabalho - Ontem", image: UIImage(named: "news2.jpeg")!) )
        
        fakenews.append(Noticia(titulo: "Trabalho em frigoríficos: audiências públicas no PR e SC discutem revisão da NR 36", resumo: "Eliminação de pausas ameaça segurança de mais de 550 mil empregados do setor no Brasil", body: "aqiu vai o <strong>html</strong> ", info: "Trabalho escravo - Hoje", image: UIImage()) )
        
        fakenews.append(Noticia(titulo: "Destinação para APAE de Campo Verde (MT) vai possibilitar construção de brinquedoteca e cinema", resumo: "Novo espaço criará diferentes situações de aprendizagem, estimulando a socialização e a integração", body: "Cuiabá - A Associação de Pais e Amigos dos Excepcionais (APAE) de Campo Verde, município localizado a cerca de 130 km de Cuiabá, foi beneficiada com duas destinações do Ministério Público do Trabalho em Mato Grosso (MPT-MT), uma delas feita em parceria com a Justiça do Trabalho. O valor revertido vai contribuir com a aquisição de materiais de construção para execução de projeto de uma brinquedoteca e de uma área de cinema para crianças e adolescentes atendidos pela entidade.", info: "Trabalho escravo - Hoje", image: UIImage()) )
        
        fakenews.append(Noticia(titulo: "Recursos provenientes da atuação do MPT garantem a entrega de 15 mil cestas básicas em Santa Catarina", resumo: "Ação é fruto de uma parceria da instituição com a agência da ONU, o Instituto Pe. Vilson Groh (IVG), e organizações da sociedade civil", body: "Cuiabá - A Associação de Pais e Amigos dos Excepcionais (APAE) de Campo Verde, município localizado a cerca de 130 km de Cuiabá, foi beneficiada com duas destinações do Ministério Público do Trabalho em Mato Grosso (MPT-MT), uma delas feita em parceria com a Justiça do Trabalho. O valor revertido vai contribuir com a aquisição de materiais de construção para execução de projeto de uma brinquedoteca e de uma área de cinema para crianças e adolescentes atendidos pela entidade.", info: "TMPT em Santa Catarina - 19/11/2021", image: UIImage(named: "news3.jpeg")!) )
        
        
        return fakenews
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvNews.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        cell.Prepare(with: news[indexPath.row])
       
        return cell
    }
}
