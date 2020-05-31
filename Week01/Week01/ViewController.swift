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
    
    private let redColors = [CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 0.25), CGColor(srgbRed: 0.96, green: 0.26, blue: 0.21, alpha: 1)]
    private let greenColors = [CGColor(srgbRed: 0.30, green: 0.67, blue: 0.31, alpha: 0.25), CGColor(srgbRed: 0.30, green: 0.67, blue: 0.31, alpha: 1)]
    private let blueColors = [CGColor(srgbRed: 0.13, green: 0.59, blue: 0.95, alpha: 0.25), CGColor(srgbRed: 0.13, green: 0.59, blue: 0.95, alpha: 1)]
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sliderBgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        setRadius(view: titleLabel)
        setRadius(view: sliderBgView)
        setSlider(slider: redSlider, cgColors: redColors, thumbNormal: #imageLiteral(resourceName: "redSelector"), thumbHighlite: #imageLiteral(resourceName: "redHighlite"))
        setSlider(slider: greenSlider, cgColors: greenColors, thumbNormal: #imageLiteral(resourceName: "greenSelector"), thumbHighlite: #imageLiteral(resourceName: "greenHighlite"))
        setSlider(slider: blueSlider, cgColors: blueColors, thumbNormal: #imageLiteral(resourceName: "blueSelector"), thumbHighlite: #imageLiteral(resourceName: "blueHighlite"))
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
        tgl.startPoint = CGPoint.init(x:0.0, y:1)
        tgl.endPoint = CGPoint.init(x:1.0, y:1)

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


}

