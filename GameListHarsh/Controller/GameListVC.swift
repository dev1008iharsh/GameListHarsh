//
//  GameListVC.swift
//  GameListHarsh
//
//  Created by My Mac Mini on 07/02/24.
//

import UIKit

class GameListVC: UIViewController {

  
    @IBOutlet weak var tblGameList: UITableView!
    
    @IBOutlet weak var btnNext: UIBarButtonItem!
    var marrGame = [SubCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblGameList.dataSource = self
        tblGameList.delegate = self
        tblGameList.separatorStyle = .none
        
        let nib = UINib(nibName: "GameListTVC", bundle: nil)
        tblGameList.register(nib, forCellReuseIdentifier: "GameListTVC")
        
        
        let barButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = barButtonItem
        
        getData()
    }
    
    @objc func buttonTapped() {
        // Handle button tap event here
        print("Button tapped")
        let secondViewController = self.storyboard!.instantiateViewController(withIdentifier: "InputVC") as! InputVC
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
   
    func getData() {
        DispatchQueue.main.async {
            Utility.shared.showLoader(true)
        }
       
        // Define the URL for the API endpoint
        guard let apiUrl = URL(string: "https://artwork.vasundharaapps.com/artwork_cache/api/AdvertiseNewApplications/17/com.fancy.fonts.style.keyboard.emojis.screen.number") else {
            fatalError("Invalid URL")
        }
 
        let session = URLSession.shared
 
        let task = session.dataTask(with: apiUrl) { (data, response, error) in
           
            Utility.shared.heavyHapticFeedBack()
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
        
            guard let responseData = data else {
                print("Error: No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let modelGame = try decoder.decode(ModelGame.self, from: responseData)
            
                print("Status: \(modelGame.status)")
                  
                for appCenter in modelGame.appCenter {
                    self.marrGame.append(contentsOf: appCenter.subCategory)
                }
                print(self.marrGame)
                DispatchQueue.main.async {
                    Utility.shared.showLoader(false)
                    self.tblGameList.reloadData()
                }
                
            } catch {
                print("Error: \(error)")
                print("Error: \(error.localizedDescription)")
            }
        }

        // Start the data task
        task.resume()
        
        
    }
    
    
    

}
extension GameListVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        marrGame.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GameListTVC", for: indexPath) as? GameListTVC else{
            return UITableViewCell()
        }
        
        cell.countGame.text = marrGame[indexPath.row].installedRange
        cell.imgGame.setImage(with: marrGame[indexPath.row].icon)
        cell.titleGame.text = marrGame[indexPath.row].name
      
        cell.createCosmosView(ratingGame: (Double(marrGame[indexPath.row].star) ?? 0.0))
        cell.btnDownload.addTarget(self, action: #selector(btnDelete(sender:)), for:.touchUpInside)
        cell.btnDownload.tag = indexPath.row
         
        return cell
    }
    
    
    @objc func btnDelete(sender: UIButton) {
        if let url = URL(string: (marrGame[sender.tag].appLink ?? "")) {
            UIApplication.shared.open(url)
        }
   }
   
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
   
    
}
