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
    private var redSliderValue = 0
    private var greenSliderValue = 0
    private var blueSliderValue = 0
    
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redValueTxt: UILabel!
    @IBOutlet weak var greenValueTxt: UILabel!
    @IBOutlet weak var blueValueTxt: UILabel!
    
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
    
    @IBAction func redSliderMoved(_ slider: UISlider){
        
        redSliderValue = Int(slider.value.rounded())
        redValueTxt.text = String(format: "%03d", redSliderValue)
        
    }
    
    @IBAction func greenSliderMoved(_ slider: UISlider){
        
        greenSliderValue = Int(slider.value.rounded())
        greenValueTxt.text = String(format: "%03d", greenSliderValue)
        
    }
    
    @IBAction func blueSliderMoved(_ slider: UISlider){
        
        blueSliderValue = Int(slider.value.rounded())
        blueValueTxt.text = String(format: "%03d", blueSliderValue)
        
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
        
        setSlider(slider: redSlider, cgColors: redColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: greenSlider, cgColors: greenColors, thumbNormal: #imageLiteral(resourceName: "greenSelector"), thumbHighlite: #imageLiteral(resourceName: "greenHighlite"))
        setSlider(slider: blueSlider, cgColors: blueColors, thumbNormal: #imageLiteral(resourceName: "blueSelector"), thumbHighlite: #imageLiteral(resourceName: "blueHighlite"))
        
        redLabel.text = "Red"
        redSlider.maximumValue = 255
        redSlider.minimumValue = 0
        redSliderValue = 255
        redSlider.value = Float(redSliderValue)
        redValueTxt.text = String(format: "%03d", redSliderValue)
        
        greenLabel.text = "Green"
        greenSlider.maximumValue = 255
        greenSlider.minimumValue = 0
        greenSliderValue = 255
        greenSlider.value = Float(greenSliderValue)
        greenValueTxt.text = String(format: "%03d", greenSliderValue)
        
        blueLabel.text = "Blue"
        blueSlider.maximumValue = 255
        blueSlider.minimumValue = 0
        blueSliderValue = 255
        blueSlider.value = Float(blueSliderValue)
        blueValueTxt.text = String(format: "%03d", blueSliderValue)
        
        colorName = " My Awesome Color "
        setColor()
    }
    
    private func setUpHSB(){
        
        isRGBActivated = false
        
        setSlider(slider: redSlider, cgColors: hueColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: greenSlider, cgColors: satColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: blueSlider, cgColors: brightColors, thumbNormal: #imageLiteral(resourceName: "brightSelector"), thumbHighlite: #imageLiteral(resourceName: "brightHighlite"))
        
        redLabel.text = "Hue"
        redSlider.maximumValue = 360
        redSlider.minimumValue = 0
        redSliderValue = 360
        redSlider.value = Float(redSliderValue)
        redValueTxt.text = String(format: "%03d", redSliderValue)
        
        greenLabel.text = "Saturation"
        greenSlider.maximumValue = 100
        greenSlider.minimumValue = 0
        greenSliderValue = 0
        greenSlider.value = Float(greenSliderValue)
        greenValueTxt.text = String(format: "%03d", greenSliderValue)
        
        blueLabel.text = "Brightness"
        blueSlider.maximumValue = 100
        blueSlider.minimumValue = 0
        blueSliderValue = 100
        blueSlider.value = Float(blueSliderValue)
        blueValueTxt.text = String(format: "%03d", blueSliderValue)
        
        colorName = " My Awesome Color "
        setColor()
    }

    private func setColor(){
        
        titleLabel.text = colorName
        
        print("Red: \(redSliderValue) green: \(greenSliderValue) blue: \(blueSliderValue) ")
        
        let color: UIColor
        
        if isRGBActivated {
            
            color = UIColor(
                red: CGFloat(redSliderValue)/CGFloat(255.00),
                green: CGFloat(greenSliderValue)/CGFloat(255),
                blue: CGFloat(blueSliderValue)/CGFloat(255),
                alpha: 1)
            
        } else {
            color = UIColor(
                hue: CGFloat(redSliderValue)/CGFloat(360),
                saturation: CGFloat(greenSliderValue)/CGFloat(100),
                brightness: CGFloat(blueSliderValue)/CGFloat(100),
                alpha: 1)
        }
        
        print("Color: \(color)")
        
        
        UIView.animate(withDuration: 0.30) {
            self.colorView.backgroundColor = color
        }
    }

}

