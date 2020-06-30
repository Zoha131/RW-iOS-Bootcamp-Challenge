//
//  TextPostTableViewCell.swift
//  Birdie-Final
//
//  Created by Zoha on 6/29/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class TextPostTableViewCell: UITableViewCell {

  @IBOutlet weak var profileImage: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  }
    
  func setData(textPost: MediaPost) {
    
    nameLabel.text = textPost.userName
    timeLabel.text = textPost.getFormatedDate()
    postLabel.text = textPost.textBody
  }
}


