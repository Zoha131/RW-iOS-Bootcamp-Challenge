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

class LargeViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  let dataSource = LargeDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.register(LargeCollectionViewCell.self, forCellWithReuseIdentifier: LargeCollectionViewCell.reuseIdentifier)
    collectionView.register(LandScapeLargeCollectionViewCell.self, forCellWithReuseIdentifier: LandScapeLargeCollectionViewCell.reuseIdentifier)
    collectionView.dataSource = dataSource
    collectionView.collectionViewLayout = createCompositionalLayout()
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransition(to: size, with: coordinator)

    collectionView.collectionViewLayout.invalidateLayout()
  }
  
  func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))

        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

      let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(1))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
      
      layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 5, bottom: 40, trailing: 5)
      
        return layoutSection
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 50
    layout.configuration = config
    return layout
  }

}
