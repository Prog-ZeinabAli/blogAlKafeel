//
//  ReportViewController.swift
//  blog
//
//  Created by turath alanbiaa on 6/23/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {


    @IBOutlet weak var backroundColor: CardShadow!
    @IBOutlet weak var R1: UIButton!
    @IBOutlet weak var R2: UIButton!
    @IBOutlet weak var R3: UIButton!
    var reportValue = 0
    
    @IBOutlet weak var SendReport: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        Utilities.styleHollowButton(SendReport)
       Utilities.BrightfadedColor(backroundColor)
        
        // MARK:- hide when tapping anywhere
                             let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(Close))
                             view.addGestureRecognizer(tap)
                 }

    
    
    @IBAction func R1Tapped(_ sender: Any) {
            reportValue = 1
            R1.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
            R2.setImage(UIImage(systemName: "circle"), for: .normal)
            R3.setImage(UIImage(systemName: "circle"), for: .normal)
       
    }
    @IBAction func R2Tapped(_ sender: Any) {
        reportValue = 2
        R1.setImage(UIImage(systemName: "circle"), for: .normal)
        R2.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
        R3.setImage(UIImage(systemName: "circle"), for: .normal)
    }
    @IBAction func R3Tapped(_ sender: Any) {
        reportValue = 3
        R1.setImage(UIImage(systemName: "circle"), for: .normal)
        R2.setImage(UIImage(systemName: "circle"), for: .normal)
        R3.setImage(UIImage(systemName: "smallcircle.fill.circle"), for: .normal)
    }
    
    
    @IBAction func SendReport(_ sender: Any) {
        print("reporting line \(reportValue)")
    }
    
    
          @objc func Close() {
               guard let menuViewController = self.storyboard?.instantiateViewController(identifier: "NavigationController") else {return}
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
          }
          
    
    
    
    }
    
  

