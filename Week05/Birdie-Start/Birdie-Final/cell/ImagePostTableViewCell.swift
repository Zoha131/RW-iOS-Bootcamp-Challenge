//
//  ImagePostTableViewCell.swift
//  Birdie-Final
//
//  Created by Zoha on 6/29/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostTableViewCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var postImage: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  
  func setData(imagePost: ImagePost) {
    nameLabel.text = imagePost.userName
    timeLabel.text = imagePost.getFormatedDate()
    postLabel.text = imagePost.textBody
    postImage.image = imagePost.image
  }
  
}
