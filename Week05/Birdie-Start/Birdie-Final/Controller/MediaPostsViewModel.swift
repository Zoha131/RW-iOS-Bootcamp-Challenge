//
//  MediaPostsViewModel.swift
//  Birdie-Final
//
//  Created by Zoha on 6/29/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

  
  

class MediaPostsViewModel {
  
  let postData = MediaPostsHandler.shared
  
  func getTableViewCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let item = postData.mediaPosts[indexPath.row]
    
    if let imagePost = item as? ImagePost {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: PostType.imagePost.rawValue) as! ImagePostTableViewCell
      cell.setData(imagePost: imagePost)
      
      return cell
      
    } else{
      
      let cell = tableView.dequeueReusableCell(withIdentifier: PostType.textPost.rawValue) as! TextPostTableViewCell
      cell.setData(textPost: item)
      
      return cell
    }
  }
}
