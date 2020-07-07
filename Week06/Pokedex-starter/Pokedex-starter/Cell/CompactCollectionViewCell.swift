/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class CompactCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier = String(describing: CompactCollectionViewCell.self)
  
  let imageView = UIImageView()
  let labelView = UILabel()
  let bgView = UIView()
    
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    labelView.font = labelView.font.withSize(13)
    labelView.textColor = .white
    labelView.textAlignment = .center
    labelView.backgroundColor = UIColor(red: 1, green: 88/255, blue: 85/255, alpha: 1)
    
    bgView.backgroundColor = .white
    contentView.layer.cornerRadius = 5
    contentView.clipsToBounds = true
    
    labelView.translatesAutoresizingMaskIntoConstraints = false
    imageView.translatesAutoresizingMaskIntoConstraints = false
    bgView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(bgView)
    contentView.addSubview(imageView)
    contentView.addSubview(labelView)
    
    let labelHeight:CGFloat = 30
    let imageSize: CGFloat = 75
    
    NSLayoutConstraint.activate([
      labelView.heightAnchor.constraint(equalToConstant: labelHeight),
      labelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      labelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      labelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
      imageView.heightAnchor.constraint(equalToConstant: imageSize),
      imageView.widthAnchor.constraint(equalToConstant: imageSize),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -(labelHeight/2)),
      
      bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
      bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }
  
  func updateData(pokemon: Pokemon){
    
    labelView.text = pokemon.pokemonName
    imageView.image = UIImage(named: String(pokemon.pokemonID))
  }
}
