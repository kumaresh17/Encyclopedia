//
//  CatDetailViewController.swift
//  Encyclopedia
//
//  Created by  on 02/01/2022.
//

import UIKit

class CatDetailViewController: UIViewController,CatDetailsViewProtocol {
   
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var nameOfTheCatLabel: UILabel!
    @IBOutlet weak var catTemperamentLabel: UILabel!
    @IBOutlet weak var wikiLinkButton: UIButton!
    @IBOutlet weak var catEnergyLevelLabel: UILabel!
    
    var presenter: EncyclopediaPresenterProtocol?
    var response: CatsResponse?
    var router: CatDetailProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpDetailView()
    }
    
    func setUpDetailView() {
        nameOfTheCatLabel.text = "Cat Name: " + (response?.name ?? "")
        catTemperamentLabel.text = "Cat Temperament: " +  (response?.temperament ?? "")
        catEnergyLevelLabel.text =  "Cat Energy level: " +  (response?.energylevel.description ?? "" )
        if response?.externalLinkToWikipedia == nil {
            wikiLinkButton.isHidden = true
        }
        guard let imageUrlString = response?.imageurl else {
            catImageView.image = UIImage(named: "placeholder")!
            return }
        let imageUrl = URL(string:imageUrlString)
        catImageView.load(url: imageUrl!)
    }

    @IBAction func wikiLinkAction(_ sender: Any) {
        guard let pageUrl = response?.externalLinkToWikipedia else { return}
        router?.openWebPage(for: pageUrl)
        
    }
    
}
