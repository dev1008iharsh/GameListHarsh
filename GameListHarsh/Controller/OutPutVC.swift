//
//  OutPutVC.swift
//  GameListHarsh
//
//  Created by My Mac Mini on 07/02/24.
//

import UIKit

class OutPutVC: UIViewController {
    
    @IBOutlet weak var collvGrid: UICollectionView!
     
    var numberOfGrid = 0
    override func viewDidLoad() {
        collvGrid.dataSource = self
        collvGrid.delegate = self
        
        collvGrid.collectionViewLayout = Utility.createColumnFlowLayout(in: self.view, numberOfItem: CGFloat(numberOfGrid))
    
    }
}
  
extension OutPutVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfGrid * numberOfGrid
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutPutCVC", for: indexPath) as! OutPutCVC
        cell.txtLable.text = String(indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return
        }
        print("clicked",indexPath.row )
        let selecedCell = (indexPath.row)
        
        let n = numberOfGrid
        
        if numberOfGrid == 4{
            let result : Double = ((Double(selecedCell))/(Double(n)))
            print("result",result)
            var arrayHigh = [Int]()
            if result >= 0.0 && result <= 0.99{
                arrayHigh = [n-5,n-4,n-3,n-2,n-1]
            }else if result >= 1.0 && result <= 1.99{
                arrayHigh = [n,n+1,n+2,n+3]
            }else if result >= 2.0 && result <= 2.99{
                arrayHigh = [n+4,n+5,n+6,n+7]
            }else if result >= 3.0 && result <= 3.99{
                arrayHigh = [n+8,n+9,n+10,n+11]
            }
            
            let indexPathsArray = arrayHigh.map { IndexPath(item: $0, section: 0) }

            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
                for indexPath in indexPathsArray {
                    if let cell = collectionView.cellForItem(at: indexPath) {
                        cell.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    }
                }
            }) { (_) in
                UIView.animate(withDuration: 0.2) {
                    for indexPath in indexPathsArray {
                        if let cell = collectionView.cellForItem(at: indexPath) {
                            cell.transform = .identity
                        }
                    }
                }
            }
        }else{
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: [], animations: {
                
                guard let cell = collectionView.cellForItem(at: indexPath) else {
                    return
                } 
                cell.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }) { (_) in
                UIView.animate(withDuration: 0.2) {
                    cell.transform = .identity
                }
            }
            
            
        }
        
      
        
    }
    
    
}

class OutPutCVC: UICollectionViewCell{
    
    @IBOutlet weak var txtLable: UILabel!
}
