//
//  ImagensTableViewController.swift
//  mpt-noticias
//
//  Created by LEONARDO LUIZ SILVA SANTOS on 04/08/23.
//

import UIKit

class ImagensTableViewController: UITableViewController {
    
    @IBOutlet var tvImagens: UITableView!
    var imagens: [ImagemItem] = []
    
    @IBOutlet var aivLoading: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Rest.loadImagens { (ItemsFromRest) in
            self.imagens = ItemsFromRest
            // necessario para atualizar tableView
            DispatchQueue.main.async {
                self.tvImagens.reloadData()
                self.aivLoading.stopAnimating()
            }
        } onError: { erro in
            print(erro)
            DispatchQueue.main.async {
               self.aivLoading.stopAnimating()
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imagens.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tvImagens.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ImagensTableViewCell
        
        cell.Prepare(with: imagens[indexPath.row])
       
        return cell
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



