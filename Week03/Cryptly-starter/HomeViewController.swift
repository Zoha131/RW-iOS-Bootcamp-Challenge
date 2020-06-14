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

class HomeViewController: UIViewController{
  
  @IBOutlet weak var view1: UIView!
  @IBOutlet weak var view2: UIView!
  @IBOutlet weak var view3: UIView!
  @IBOutlet weak var headingLabel: UILabel!
  @IBOutlet weak var view1TextLabel: UILabel!
  @IBOutlet weak var view2TextLabel: UILabel!
  @IBOutlet weak var view3TextLabel: UILabel!
  @IBOutlet weak var themeSwitch: UISwitch!
  
  let cryptoData = DataGenerator.shared.generateData()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //setupViews()
    setupLabels()
    setView1Data()
    setView2Data()
    setView3Data()
    
    //print(cryptoData!)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    registerForTheme()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    unregisterForTheme()
  }
  
  func setupLabels() {
    headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
    view1TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    view2TextLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
  }
  
  func setView1Data() {
    
    if let data = cryptoData {
      
      let myCurrency: String = data.map{cryptoCurrency in cryptoCurrency.name}.joined(separator: ", ")
      
      view1TextLabel.text = myCurrency
      
      print(myCurrency)
      
      
    }
    
  }
  
  func setView2Data() {
    
    if let data = cryptoData {
      
      let encreased: String = data
        .filter{cryptoCurrency in cryptoCurrency.currentValue > cryptoCurrency.previousValue }
        .map{cryptoCurrency in cryptoCurrency.name}
        .joined(separator: ", ")
      
      view2TextLabel.text = encreased
      
      print(encreased)
    }
    
  }
  
  func setView3Data() {
    
    if let data = cryptoData {
      
      let decreased: String = data
        .filter{cryptoCurrency in cryptoCurrency.currentValue < cryptoCurrency.previousValue }
        .map{cryptoCurrency in cryptoCurrency.name}
        .joined(separator: ", ")
      
      view3TextLabel.text = decreased
      
      print(decreased)
    }
    
  }
  
  @IBAction func switchPressed(_ sender: Any) {
    
    if themeSwitch.isOn {
      ThemeManager.shared.set(theme: DarkTheme.shared)
    } else{
      ThemeManager.shared.set(theme: LightTheme.shared)
    }
    
  }
}

extension HomeViewController: Themeable {
  func registerForTheme() {
    NotificationCenter.default.addObserver(self, selector: #selector(themeChanged), name: Notification.Name.init("themeChanged"), object: nil)
  }
  
  func unregisterForTheme() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func themeChanged() {
    if let currentTheme = ThemeManager.shared.currentTheme {
      
      view1.backgroundColor = currentTheme.widgetBackgroundColor
      view2.backgroundColor = currentTheme.widgetBackgroundColor
      view3.backgroundColor = currentTheme.widgetBackgroundColor
      
      view1.layer.borderColor = currentTheme.borderColor.cgColor
      view2.layer.borderColor = currentTheme.borderColor.cgColor
      view3.layer.borderColor = currentTheme.borderColor.cgColor
      
      view1TextLabel.textColor = currentTheme.textColor
      view2TextLabel.textColor = currentTheme.textColor
      view3TextLabel.textColor = currentTheme.textColor
      
      headingLabel.textColor = currentTheme.textColor
      
      view.backgroundColor = currentTheme.backgroundColor
      
    }
  }
  
  
}
