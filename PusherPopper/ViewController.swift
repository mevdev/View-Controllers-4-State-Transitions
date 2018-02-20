//
//  ViewController.swift
//  PusherPopper
//
//  Created by Robert Linnemann on 2/19/18.
//  Copyright © 2018 Robert Linnemann. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //View Controller Transitions (4 states)
    //Know when your VC is being 'Pushed On', 'Popped To', 'Popped' or 'Put Back'
    //------------------------
    //Robert Linnemann
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //don't show pop button if this is the last view controller on the stack.
        popButton.isHidden = ((self.navigationController?.viewControllers.count ?? 1) <= 1)
        self.title = String(self.navigationController?.viewControllers.count ?? 1)
    }

     // MARK: The Magic
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isBeingPresented || isMovingToParentViewController {
            //'Pushed On'
            animateLabel(title: "Pushed On")
        } else {
            //'Popped To'
            animateLabel(title: "Popped To")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController {
           animateLabel(title: "Popped")
        } else {
           animateLabel(title: "Put Back")
        }
    }
    
    //helper method.
    func animateLabel(title: String) {
        infoLabel.text = title
        //we'll change back out label after the transition.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.infoLabel.text = self.title
        }
        
    }
    
    
     // MARK: Actions
    @IBAction func pushAction() {
        //grab another!
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func popAction() {
        //pop thyself if you are not the last.
        self.navigationController?.popViewController(animated: true)
    }
    

}

