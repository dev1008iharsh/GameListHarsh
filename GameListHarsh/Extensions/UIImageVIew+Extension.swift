//
//  UIImageVIew+Extension.swift
//  GameListHarsh
//
//  Created by My Mac Mini on 07/02/24.
//

import Foundation
import UIKit
 
extension UIImageView{
   
    func setImage(with urlString: String) {
        Utility.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}

extension UIImpactFeedbackGenerator {
    enum ImpactStyle {
        case lightImpact, mediumImpact, heavyImpact
    }
    
    convenience init(style: ImpactStyle) {
        switch style {
        case .lightImpact:
            self.init(style: .light)
        case .mediumImpact:
            self.init(style: .medium)
        case .heavyImpact:
            self.init(style: .heavy)
        }
    }
    
    func impact() {
        self.prepare()
        self.impactOccurred()
    }
}
