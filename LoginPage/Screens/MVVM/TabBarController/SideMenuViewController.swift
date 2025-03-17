//
//  SideMenuViewController.swift
//  LoginPage
//
//  Created by Digitalflake on 07/01/25.
//

import UIKit
protocol SideMenuDelegate: AnyObject {
    func hideContainerView()
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var socialMediaContainerView: UIView!
    
    @IBOutlet weak var containerView: UIView!
    weak var delegate: SideMenuDelegate? // Delegate property
        
    override func viewDidLoad() {
        super.viewDidLoad()
        socialMediaContainerView.layer.cornerRadius = 10
        socialMediaContainerView.layer.masksToBounds = true
        
    }
 
    @IBAction func sideMenuBarCancelButton(_ sender: Any) {
    
        self.delegate?.hideContainerView()
        self.dismiss(animated: true)
        self.hideContainerView()
        print("cancelButtonTapped")
        
       
        dismiss(animated: true)
       
       
    }
    
    func hideContainerView() {
        // Hide the container view
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.frame.origin.x = -self.containerView.frame.width
        }) { _ in
            self.containerView.alpha = 0
            self.containerView.isHidden = true
            
            self.removeFromParent()
            self.view.removeFromSuperview()
        }
    }

    
    @IBAction func homeButton(_ sender: Any) {
        
        
    }
    
    @IBAction func mySubScription(_ sender: Any) {
        
        
    }
    
    @IBAction func myVacationButton(_ sender: Any) {
        
        
    }
    
    @IBAction func referralFriendButton(_ sender: Any) {
        
        
    }
    @IBAction func hummpyAppButtun(_ sender: Any) {
        
        
    }
    @IBAction func rateingButtun(_ sender: Any) {
        
        
    }
    @IBAction func repostAnIssueButton(_ sender: Any) {
        
        
    }
    
    
}
