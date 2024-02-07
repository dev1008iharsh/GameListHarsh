//
//  GameListTVC.swift
//  GameListHarsh
//
//  Created by My Mac Mini on 07/02/24.
//

import UIKit
import Cosmos
 
class GameListTVC: UITableViewCell {

    @IBOutlet weak var viewConsmosContainer: UIView!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var countGame: UILabel!
    @IBOutlet weak var titleGame: UILabel!
    @IBOutlet weak var imgGame: UIImageView!
 
    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        confugureCellElements()
         
    }
    
    func createCosmosView(ratingGame : Double){
       
        let cosmosView = CosmosView()
        cosmosView.rating = ratingGame
        cosmosView.settings.updateOnTouch = false
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.filledColor = .systemGray
        cosmosView.settings.filledBorderColor = .systemGray
        cosmosView.settings.emptyBorderColor = .systemGray
    
        cosmosView.settings.starMargin = 0
        viewConsmosContainer.addSubview(cosmosView)
        
        cosmosView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cosmosView.leadingAnchor.constraint(equalTo: viewConsmosContainer.leadingAnchor),
            cosmosView.centerXAnchor.constraint(equalTo: viewConsmosContainer.centerXAnchor),
            cosmosView.centerYAnchor.constraint(equalTo: viewConsmosContainer.centerYAnchor)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    
        countGame.text = nil
        titleGame.text = nil
        imgGame.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func confugureCellElements(){
        // Add shadow
        btnDownload.layer.cornerRadius = 17
        bgView.layer.cornerRadius = 20
        imgGame.layer.cornerRadius = 20
        bgView.layer.shadowColor = UIColor.green.cgColor
        bgView.layer.shadowOpacity = 1
        bgView.layer.shadowOffset = .zero
        bgView.layer.shadowRadius = 5
    }
    
}
