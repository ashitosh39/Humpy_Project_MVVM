//
//  HomeViewController.swift
//  LoginPage
//
//  Created by Digitalflake on 07/01/25.
//

import UIKit

class HomeViewController: UIViewController, SideMenuDelegate {
   
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var sideMenuBarButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    private var isContainerViewOpen = false
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.isHidden = true
        containerView.alpha = 0
               // Add a tap gesture recognizer to detect taps outside the container
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutsideContainer(_:)))
               self.view.addGestureRecognizer(tapGesture)
        
               containerView.layer.cornerRadius = 20  // Set the corner radius (adjust as needed)
               containerView.layer.masksToBounds = true  // Ensure the subviews are clipped to the corner
        topView.layer.cornerRadius = 50
        topView.layer.masksToBounds = true
    }
    // In HomeViewController
    func hideContainerView() {
        // Hide the container view
        UIView.animate(withDuration: 0.3, animations: {
            self.containerView.alpha = 0
            self.containerView.frame.origin.x = -self.containerView.frame.width
        }) { _ in
            self.containerView.isHidden = true
            self.sideMenuBarButton.isHidden = false
            self.tabBarController?.tabBar.isHidden = false
            
//            self.view.removeFromSuperview()
        }
    }
    func showContainerView() {
           containerView.isHidden = false
           UIView.animate(withDuration: 0.3, animations: {
               self.containerView.alpha = 1
               self.sideMenuBarButton.isHidden = true
               self.containerView.frame.origin.x = 0
           }) { _ in
               self.sideMenuBarButton.isHidden = true
               self.tabBarController?.tabBar.isHidden = true
           }
       }
       
    // In HomeViewController
//    func closeContainerView() {
//            // Hide the container view and reset UI elements
//            hideContainerView()
//
//            // If the side menu is presented modally, dismiss it
//            if let sideMenuVC = presentedViewController as? SideMenuViewController {
//                sideMenuVC.dismiss(animated: true, completion: nil)
//            }
//        }
   
    @IBAction func sideMenuBarButtonTapped(_ sender: UIButton) {
        isContainerViewOpen.toggle()
                
                if isContainerViewOpen {
                    showContainerView()
                } else {
                    hideContainerView()
                }
       }
       
       // Method to handle tap outside the container view
    @objc func handleTapOutsideContainer(_ sender: UITapGestureRecognizer) {
        if isContainerViewOpen {
                    let location = sender.location(in: self.view)
                    if !containerView.frame.contains(location) {
                        isContainerViewOpen = false
                        hideContainerView()
                    }
            }
    }
    func presentSideMenu() {
            if let sideMenuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController {
                sideMenuVC.delegate = self  // Set the delegate to HomeViewController
                self.present(sideMenuVC, animated: true, completion: nil)
        }
    }
}
    




















//func dismissAlert() {
//    UIView.animate(withDuration: 0.3, animations: {
//        self.containerView.frame.origin.x = -self.containerView.frame.width
//            }) { _ in
//                self.containerView.alpha = 0
//                self.containerView.isHidden = true
//                
//                self.removeFromParent()
//                self.view.removeFromSuperview()
//                // After dismissing the alert, pop the view controller to navigate back
//              
//            }
//        }
