//
//  ViewController.swift
//  Birdie-Final
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var tableview: UITableView!
  
  let postData = MediaPostsHandler.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    postData.getPosts()
    setUpTableView()
  }
  
  func setUpTableView() {
    // Set delegates, register custom cells, set up datasource, etc.
    tableview.register(UINib(nibName: PostType.textPost.rawValue, bundle: nil), forCellReuseIdentifier: PostType.textPost.rawValue)
    tableview.register(UINib(nibName: PostType.imagePost.rawValue, bundle: nil), forCellReuseIdentifier: PostType.imagePost.rawValue)
    tableview.dataSource = self
    tableview.delegate = self
  }
  
  @IBAction func didPressCreateTextPostButton(_ sender: Any) {
    
  }
  
  @IBAction func didPressCreateImagePostButton(_ sender: Any) {
    
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postData.mediaPosts.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
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



