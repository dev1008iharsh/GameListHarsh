//
//  Utility.shared.swift
//  NewsAppHarsh
//
//  Created by My Mac Mini on 06/02/24.
//

import Foundation
import UIKit

class Utility{
    static let shared = Utility()
    private init(){}
    
    let cache = NSCache<NSString, UIImage>()
    
    static func createColumnFlowLayout(in view: UIView, numberOfItem : CGFloat) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 5
        let minimumItemSpacing: CGFloat = 5
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / (numberOfItem + 1)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return flowLayout
    }
    
    func showLoader(_ show: Bool, loadingText : String = "") {
         
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return }
        guard let _ = windowScene.windows.last else { return }
        windowScene.keyWindow?.viewWithTag(1200)
        //UIApplication.shared.window[0].viewWithTag(1200)
        let existingView = windowScene.keyWindow?.viewWithTag(1200)
        
        if show {
            if existingView != nil {
                return
            }
            let loadingView =  makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
            loadingView?.tag = 1200
            windowScene.keyWindow?.addSubview(loadingView!)
        } else {
            existingView?.removeFromSuperview()
        }

    }



    func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
         
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.tag = 100 // 100 for example

        loadingView.addSubview(activityIndicator)
        if !text!.isEmpty {
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
            lbl.center = cpoint
            lbl.textColor = UIColor.white
            lbl.textAlignment = .center
            lbl.text = text
            lbl.tag = 1234
            loadingView.addSubview(lbl)
        }
        return loadingView
    }
    
    public func showAlertHandler(title:String, message: String, view:UIViewController,okAction:@escaping ((UIAlertAction) -> Void)) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: okAction))
        view.present(alert, animated: true, completion: nil)
    }
    
    func heavyHapticFeedBack(){
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavyImpact)
        feedbackGenerator.impact()
    }
    func lightHapticFeedBack(){
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .lightImpact)
        feedbackGenerator.impact()
    }
    
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        // Create cache key
        let cacheKey = NSString(string: urlString)
        
        // Check if image is already in cache
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        // Check if URL is valid
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        // Perform URL session task
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            
            // Check for errors and valid HTTP response
            guard error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            // Store image in cache and call completion handler
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        // Start the task
        task.resume()
    }

    
}
