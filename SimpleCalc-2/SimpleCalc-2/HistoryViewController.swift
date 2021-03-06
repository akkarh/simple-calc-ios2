//
//  HistoryViewController.swift
//  SimpleCalc-2
//
//  Created by Harshitha Akkaraju on 2/3/18.
//  Copyright © 2018 Harshitha Akkaraju. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
        print(expressions)
        if expressions.count > 0 {
            for i in 0...expressions.count - 1 {
                let label = UILabel(frame: CGRect(x: 0, y: i * 30, width: Int(self.view.frame.size.width), height: 30))
                label.textColor = UIColor.white
                label.text = expressions[i]
                scrollView.addSubview(label)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToCalc(_ sender: UIButton) {
        performSegue(withIdentifier: "calcVC", sender: self)
    }
    
    var expressions = [String]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
