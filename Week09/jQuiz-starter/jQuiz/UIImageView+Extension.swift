//
//  UIImageView+Extension.swift
//  jQuiz
//
//  Created by Zoha on 7/28/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIImageView {
  
  public static var imageCache: [String: UIImage] = [:]
  
  public func setImage(fromUrlPath urlPath: String){
    
    if let image = UIImageView.imageCache[urlPath] {
      self.image = image
      return
    }
    
    guard let imageUrl = URL(string: urlPath) else {
      fatalError("Wrong path")
    }
    
    URLSession.shared.downloadTask(with: imageUrl) { (localUrl, response, error) in
      do {
        let data = try Data(contentsOf: localUrl!)
        let image = UIImage(data: data)
        UIImageView.imageCache[urlPath] = image
        
        DispatchQueue.main.async {
          self.image = image
        }
      }catch let error {
        print("\(error.localizedDescription)")
      }
      
    }.resume()
  }
}
