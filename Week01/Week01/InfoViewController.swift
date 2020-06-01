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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = URL(string: "https://en.wikipedia.org/wiki/RGB_color_model") {
            let request = URLRequest(url: url)
            infoWeb.load(request)
        }
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }

}
