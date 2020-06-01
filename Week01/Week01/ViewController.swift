//
//  ViewController.swift
//  Week01
//
//  Created by Zoha on 5/31/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let radius = CGFloat(4.0)
    
    private let redColors = [
        CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 0.25),
        CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 1)
    ]
    private let greenColors = [
        CGColor(srgbRed: 0.30, green: 0.67, blue: 0.31, alpha: 0.25),
        CGColor(srgbRed: 0.30, green: 0.67, blue: 0.31, alpha: 1)
    ]
    private let blueColors = [
        CGColor(srgbRed: 0.13, green: 0.59, blue: 0.95, alpha: 0.25),
        CGColor(srgbRed: 0.13, green: 0.59, blue: 0.95, alpha: 1)
    ]
    
    private let hueColors = [
        CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 1),
        CGColor(srgbRed: 0.30, green: 0.67, blue: 0.31, alpha: 1),
        CGColor(srgbRed: 0.13, green: 0.59, blue: 0.95, alpha: 1),
        CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 1)
    ]
    
    private let satColors = [
        CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 0.25),
        CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 1)
    ]
    
    private let brightColors = [
        UIColor.black.cgColor,
        UIColor.white.cgColor
    ]
    
    private var isRGBActivated = true
    
    private var colorName = " My Awesome Color "
    private var firstSliderValue = 0
    private var secondSliderValue = 0
    private var thirdSliderValue = 0
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var thirdSlider: UISlider!
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var firstValueTxt: UILabel!
    @IBOutlet weak var secondValueTxt: UILabel!
    @IBOutlet weak var thirdValueTxt: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sliderBgView: UIView!
    @IBOutlet weak var colorView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        setRadius(view: titleLabel)
        setRadius(view: sliderBgView)
        setUpRGB()
    }
    
    
    private func setRadius(view: UIView){
        view.layer.cornerRadius = radius
        view.layer.masksToBounds = true
    }
    
    private func setSlider(slider:UISlider, cgColors: [CGColor], thumbNormal: UIImage, thumbHighlite: UIImage) {
        let tgl = CAGradientLayer()
        let frame = CGRect.init(x:0, y:0, width:slider.frame.size.width, height:10)
        tgl.frame = frame
        tgl.cornerRadius = 5
        tgl.masksToBounds = true
        tgl.colors = cgColors
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(tgl.frame.size, tgl.isOpaque, 0.0);
        tgl.render(in: UIGraphicsGetCurrentContext()!)
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()

            image.resizableImage(withCapInsets: UIEdgeInsets.zero)

            slider.setMinimumTrackImage(image, for: .normal)
            slider.setMaximumTrackImage(image, for: .normal)
            
            slider.setThumbImage(thumbNormal, for: .normal)
            slider.setThumbImage(thumbHighlite, for: .highlighted)

        }
    }
    
    @IBAction func modeChanged(_ sender: Any){
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            setUpRGB()
        default:
            setUpHSB()
        }
    }
    
    @IBAction func firstSliderMoved(_ slider: UISlider){
        
        firstSliderValue = Int(slider.value.rounded())
        firstValueTxt.text = String(format: "%03d", firstSliderValue)
        
    }
    
    @IBAction func secondSliderMoved(_ slider: UISlider){
        
        secondSliderValue = Int(slider.value.rounded())
        secondValueTxt.text = String(format: "%03d", secondSliderValue)
        
    }
    
    @IBAction func thirdSliderMoved(_ slider: UISlider){
        
        thirdSliderValue = Int(slider.value.rounded())
        thirdValueTxt.text = String(format: "%03d", thirdSliderValue)
        
    }
    
    @IBAction func setColorAction(){
        
        let atertController = UIAlertController(
            title: title,
            message: "Name your color",
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            
            let nameTxtField = atertController.textFields![0]
            self.colorName = " \(nameTxtField.text!) "
            self.setColor()
        })
        
        atertController.addAction(action)
        
        atertController.addTextField(configurationHandler: nil)
        
        present(atertController, animated: true, completion: nil)
    }
    
    @IBAction func reset(){
        if isRGBActivated {
            setUpRGB()
        } else {
            setUpHSB()
        }
    }
    
    private func setUpRGB(){
        
        isRGBActivated = true
        
        setSlider(slider: firstSlider, cgColors: redColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: secondSlider, cgColors: greenColors, thumbNormal: #imageLiteral(resourceName: "greenSelector"), thumbHighlite: #imageLiteral(resourceName: "greenHighlite"))
        setSlider(slider: thirdSlider, cgColors: blueColors, thumbNormal: #imageLiteral(resourceName: "blueSelector"), thumbHighlite: #imageLiteral(resourceName: "blueHighlite"))
        
        firstLabel.text = "Red"
        firstSlider.maximumValue = 255
        firstSlider.minimumValue = 0
        firstSliderValue = 255
        firstSlider.value = Float(firstSliderValue)
        firstValueTxt.text = String(format: "%03d", firstSliderValue)
        
        secondLabel.text = "Green"
        secondSlider.maximumValue = 255
        secondSlider.minimumValue = 0
        secondSliderValue = 255
        secondSlider.value = Float(secondSliderValue)
        secondValueTxt.text = String(format: "%03d", secondSliderValue)
        
        thirdLabel.text = "Blue"
        thirdSlider.maximumValue = 255
        thirdSlider.minimumValue = 0
        thirdSliderValue = 255
        thirdSlider.value = Float(thirdSliderValue)
        thirdValueTxt.text = String(format: "%03d", thirdSliderValue)
        
        colorName = " My Awesome Color "
        setColor()
    }
    
    private func setUpHSB(){
        
        isRGBActivated = false
        
        setSlider(slider: firstSlider, cgColors: hueColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: secondSlider, cgColors: satColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: thirdSlider, cgColors: brightColors, thumbNormal: #imageLiteral(resourceName: "brightSelector"), thumbHighlite: #imageLiteral(resourceName: "brightHighlite"))
        
        firstLabel.text = "Hue"
        firstSlider.maximumValue = 360
        firstSlider.minimumValue = 0
        firstSliderValue = 360
        firstSlider.value = Float(firstSliderValue)
        firstValueTxt.text = String(format: "%03d", firstSliderValue)
        
        secondLabel.text = "Saturation"
        secondSlider.maximumValue = 100
        secondSlider.minimumValue = 0
        secondSliderValue = 0
        secondSlider.value = Float(secondSliderValue)
        secondValueTxt.text = String(format: "%03d", secondSliderValue)
        
        thirdLabel.text = "Brightness"
        thirdSlider.maximumValue = 100
        thirdSlider.minimumValue = 0
        thirdSliderValue = 100
        thirdSlider.value = Float(thirdSliderValue)
        thirdValueTxt.text = String(format: "%03d", thirdSliderValue)
        
        colorName = " My Awesome Color "
        setColor()
    }

    private func setColor(){
        
        titleLabel.text = colorName
        
        let color: UIColor
        
        if isRGBActivated {
            color = UIColor(
                red: CGFloat(firstSliderValue)/CGFloat(255.00),
                green: CGFloat(secondSliderValue)/CGFloat(255),
                blue: CGFloat(thirdSliderValue)/CGFloat(255),
                alpha: 1)
            
        } else {
            color = UIColor(
                hue: CGFloat(firstSliderValue)/CGFloat(360),
                saturation: CGFloat(secondSliderValue)/CGFloat(100),
                brightness: CGFloat(thirdSliderValue)/CGFloat(100),
                alpha: 1)
        }
        
        UIView.animate(withDuration: 0.30) {
            self.colorView.backgroundColor = color
        }
    }

}

