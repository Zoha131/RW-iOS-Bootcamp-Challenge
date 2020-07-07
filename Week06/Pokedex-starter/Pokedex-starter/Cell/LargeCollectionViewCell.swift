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

class LargeCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier = String(describing: LargeCollectionViewCell.self)
  
  let imageView = UIImageView()
  
  let nameLabel = UILabel()
  
  let baseLabel = UILabel()
  let baseValue = UILabel()
  let heightLabel = UILabel()
  let heightValue = UILabel()
  let widthLabel = UILabel()
  let widthValue = UILabel()
  
  let bgView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    bgView.backgroundColor = .white
    contentView.layer.cornerRadius = 5
    contentView.clipsToBounds = true
    
    bgView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(bgView)
    
    NSLayoutConstraint.activate([
      bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      bgView.topAnchor.constraint(equalTo: contentView.topAnchor)
    ])
    
    imageView.image = #imageLiteral(resourceName: "34")
    nameLabel.text = "Majha"
    nameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    let topStackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
    
    topStackView.distribution = .equalCentering
    topStackView.alignment = .center
    topStackView.axis = .vertical
    
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(topStackView)
        
    baseLabel.text = "Base Exp"
    baseValue.text = "46"
    let baseStackView = UIStackView(arrangedSubviews: [baseLabel, baseValue])
    baseStackView.distribution = .equalSpacing
    baseStackView.axis = .horizontal
    
    heightLabel.text = "Height"
    heightValue.text = "46"
    let heightStackView = UIStackView(arrangedSubviews: [heightLabel, heightValue])
    heightStackView.distribution = .equalSpacing
    heightStackView.axis = .horizontal
        
    widthLabel.text = "Weight"
    widthValue.text = "46"
    let widthStackView = UIStackView(arrangedSubviews: [widthLabel, widthValue])
    widthStackView.distribution = .equalSpacing
    widthStackView.axis = .horizontal
    
    let bottomStackView = UIStackView(arrangedSubviews: [baseStackView, heightStackView, widthStackView])
    
    bottomStackView.distribution = .equalSpacing
    bottomStackView.alignment = .fill
    bottomStackView.axis = .vertical
    
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(bottomStackView)
    
    NSLayoutConstraint.activate([
      topStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.80),
      topStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
      topStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      topStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35)
    ])
    
    NSLayoutConstraint.activate([
      bottomStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.80),
      bottomStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
      bottomStackView.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
      bottomStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }
  
  
  func updateData(pokemon: Pokemon){
    
    imageView.image = UIImage(named: String(pokemon.pokemonID))
    nameLabel.text = pokemon.pokemonName
    
    baseValue.text = String(pokemon.baseExp)
    heightValue.text = String(pokemon.height)
    widthValue.text = String(pokemon.weight)
  }
  
}


class LandScapeLargeCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier = String(describing: LandScapeLargeCollectionViewCell.self)
  
  let imageView = UIImageView()
  
  let nameLabel = UILabel()
  
  let baseLabel = UILabel()
  let baseValue = UILabel()
  let heightLabel = UILabel()
  let heightValue = UILabel()
  let widthLabel = UILabel()
  let widthValue = UILabel()
  
  let bgView = UIView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    bgView.backgroundColor = .white
    contentView.layer.cornerRadius = 5
    contentView.clipsToBounds = true
    
    bgView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(bgView)
    
    NSLayoutConstraint.activate([
      bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      bgView.topAnchor.constraint(equalTo: contentView.topAnchor)
    ])
    
    imageView.image = #imageLiteral(resourceName: "34")
    nameLabel.text = "Majha"
    nameLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    let topStackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
    
    topStackView.distribution = .equalCentering
    topStackView.alignment = .center
    topStackView.axis = .vertical
    
    topStackView.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(topStackView)
        
    baseLabel.text = "Base Exp"
    baseValue.text = "46"
    let baseStackView = UIStackView(arrangedSubviews: [baseLabel, baseValue])
    baseStackView.distribution = .equalSpacing
    baseStackView.axis = .horizontal
    
    heightLabel.text = "Base Exp"
    heightValue.text = "46"
    let heightStackView = UIStackView(arrangedSubviews: [heightLabel, heightValue])
    heightStackView.distribution = .equalSpacing
    heightStackView.axis = .horizontal
        
    widthLabel.text = "Base Exp"
    widthValue.text = "46"
    let widthStackView = UIStackView(arrangedSubviews: [widthLabel, widthValue])
    widthStackView.distribution = .equalSpacing
    widthStackView.axis = .horizontal
    
    let bottomStackView = UIStackView(arrangedSubviews: [baseStackView, heightStackView, widthStackView])
    
    bottomStackView.distribution = .equalSpacing
    bottomStackView.alignment = .fill
    bottomStackView.axis = .vertical
    
    bottomStackView.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(bottomStackView)
    
    NSLayoutConstraint.activate([
      topStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
      topStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
      topStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      topStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80)
    ])
    
    NSLayoutConstraint.activate([
      bottomStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35),
      bottomStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
      bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      bottomStackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.80)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("Storyboard not supported")
  }
  
  func updateData(pokemon: Pokemon){
    
    imageView.image = UIImage(named: String(pokemon.pokemonID))
    nameLabel.text = pokemon.pokemonName
    
    baseValue.text = String(pokemon.baseExp)
    heightValue.text = String(pokemon.height)
    widthValue.text = String(pokemon.weight)
  }
}
