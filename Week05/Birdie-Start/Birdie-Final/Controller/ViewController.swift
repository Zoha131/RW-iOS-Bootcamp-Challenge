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
  let viewModel = MediaPostsViewModel()
  
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
    
    openAlertView()
    
  }
  
  func openAlertView(image: UIImage? = nil) {
    let alert = UIAlertController(title: "Create Post", message: "What's up? :]", preferredStyle: UIAlertController.Style.alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
    
    let okAction = UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
      
      if let userName = alert.textFields?[0].text {
        
        let postTxt = alert.textFields?[1].text
        let time = Date()
        
        if let postImage = image {
          
          let imagePost = ImagePost(textBody: postTxt, userName: userName, timestamp: time, image: postImage)
          
          self.postData.addImagePost(imagePost: imagePost)
          
          if let index = self.postData.mediaPosts.firstIndex(where: {$0.timestamp == imagePost.timestamp}) {
            
            let indexPath = IndexPath(row: index, section: 0)
            self.tableview.insertRows(at: [indexPath], with: .automatic)
          }
          
        } else {
          let texstPost = TextPost(textBody: postTxt, userName: userName, timestamp: time)
          
          self.postData.addTextPost(textPost: texstPost)
          
          if let index = self.postData.mediaPosts.firstIndex(where: {$0.timestamp == texstPost.timestamp}) {
            
            let indexPath = IndexPath(row: index, section: 0)
            self.tableview.insertRows(at: [indexPath], with: .automatic)
          }
        }
      }
    })
    
    alert.addTextField { (textField) in
      textField.placeholder = "Username"
    }
    
    alert.addTextField { (textField) in
      textField.placeholder = "what's in your mind?"
    }
    
    alert.addAction(okAction)
    alert.addAction(cancelAction)
    
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func didPressCreateImagePostButton(_ sender: Any) {
    
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = false
    picker.sourceType = .photoLibrary
    picker.modalPresentationStyle = .fullScreen
    
    self.present(picker, animated: true, completion: nil)
  }
  
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postData.mediaPosts.count
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return nil
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    return viewModel.getTableViewCell(tableView, cellForRowAt: indexPath)
    
  }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    picker.dismiss(animated: true, completion: nil)
    
    if let result = info[UIImagePickerController.InfoKey.originalImage],
       let image = result as? UIImage{
      
      openAlertView(image: image)
      
    }
  }
  
}



