//
//  ViewController.swift
//  InMindApp
//
//  Created by Dorian Solant on 12/05/2020.
//  Copyright © 2020 Dorian Solant. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table : UITableView!
    @IBOutlet weak var sectionLabel: UILabel!
    
    // TextField et Button pour ajouter des données
    @IBOutlet weak var myTextField: UITextField!
    
    var models = [Model]()
    var listes : [VideoCourseList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateListe()
        sectionLabel.text = "Maths"
        
        models.append(Model(text: "Quatrième", imageName: "VideoCourse4"))
        models.append(Model(text: "Premier", imageName: "VideoCourse1"))
        models.append(Model(text: "Deuxième", imageName: "VideoCourse2"))
        models.append(Model(text: "Troisième", imageName: "VideoCourse3"))
        models.append(Model(text: "Quatrième", imageName: "VideoCourse4"))
        models.append(Model(text: "Quatrième", imageName: "VideoCourse4"))
        models.append(Model(text: "Premier", imageName: "VideoCourse1"))
        models.append(Model(text: "Deuxième", imageName: "VideoCourse2"))
        models.append(Model(text: "Troisième", imageName: "VideoCourse3"))
        models.append(Model(text: "Quatrième", imageName: "VideoCourse4"))
        
        table.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: CollectionTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
    }

    // setupCells(liste : listes[indexPath.row]) COMMENT FAIRE ?
    
    func updateListe () {
        CoreDataHelper().getVideosInChapter { (listes) in
            if listes != nil {
                DispatchQueue.main.async {
                    self.listes = listes!
                    self.table.reloadData()
                }
            }
        }
    }
     
    
    @IBAction func addVideo(_ sender: UIButton) {
        CoreDataHelper().saveVideo(myTextField.text)
        updateListe()
    }
    
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return models.count
        return listes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for : indexPath) as! CollectionTableViewCell
        cell.setup(with: models)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

 
    
}

struct Model {
    
    let text : String
    let imageName : String
    
    init(text : String, imageName : String) {
        
        self.text = text
        self.imageName = imageName
    }
    
}
