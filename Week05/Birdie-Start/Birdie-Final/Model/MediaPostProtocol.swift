//
//  MediaPostProtocol.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// We use this protocol so both text posts and image posts
// can be in the MediaPostsHandler.shared.mediaPosts array
protocol MediaPost {
    var textBody: String? { get set }
    var userName: String { get set }
    var timestamp: Date { get set }
}

extension MediaPost {
  
  func getFormatedDate() -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.setLocalizedDateFormatFromTemplate("MMMd'T'HH:mm")
    
    return dateFormatter.string(from: timestamp)
  }
  
}
