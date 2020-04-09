//
//  MenuViewController.swift
//  blog
//
//  Created by test1 on 4/7/20.
//  Copyright © 2020 test1. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
      


    let transition = SlideInTransition()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
        }
        
    @IBAction func HomeIsTapped(_ sender: Any) {
            dismiss(animated: true)
    }


    }




    //extention for slide menu animation
    extension MenuViewController : UIViewControllerTransitioningDelegate {
        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.isPresenting = true
            return transition
        }
        
        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            transition.isPresenting = false
            return transition
        }
            
    }
