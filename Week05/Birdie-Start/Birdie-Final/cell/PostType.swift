//
//  PostType.swift
//  Birdie-Final
//
//  Created by Zoha on 6/29/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import Foundation

// I like the type system. It helps to find bug in compile time
// That's why i have written this enum so that i don't have
// to work with raw string.
// Here, Raw value is the same as the xib file name
// Also used the raw value as cell identifier
enum PostType: String {
  case textPost = "TextPostCell"
  case imagePost = "ImagePostCell"
}
