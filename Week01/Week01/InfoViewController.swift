//
//  InfoViewController.swift
//  Week01
//
//  Created by Zoha on 6/1/20.
//  Copyright © 2020 Zoha. All rights reserved.
//

import UIKit
import WebKit

class InfoViewController: UIViewController {

    @IBOutlet weak var infoWeb: WKWebView!
    
    var infoUrl: String  = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: infoUrl) {
            let request = URLRequest(url: url)
            infoWeb.load(request)
        }
        
        
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }

}
