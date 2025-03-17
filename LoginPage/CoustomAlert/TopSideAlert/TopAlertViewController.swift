//
//  TopAlertViewController.swift
//  LoginPage
//
//  Created by Digitalflake on 30/01/25.
///@IBOutlet weak var mainTopAlertView: UIView!
import UIKit

class TopAlertViewController: UIViewController {
    
    @IBOutlet weak var topSideAlertView: UIView!
    @IBOutlet weak var alertTypeColorLabel: UILabel!
    @IBOutlet weak var alertTypeImage: UIImageView!
    @IBOutlet weak var alertTypeLabel: UILabel!
    @IBOutlet weak var alertMessageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainTopAlertView: UIView!
    private var isAlertViewLaidOut = false

    override func viewDidLoad() {
        super.viewDidLoad()
        topSideAlertView.layer.cornerRadius = 10
        topSideAlertView.clipsToBounds = true
       

        
    }
    
    func setBorderColorAndShadow() {
     
       let borderColor = UIColor(named: "topAlertBoarder")
       topSideAlertView.layer.borderColor = borderColor?.cgColor
       topSideAlertView.layer.borderWidth = 0.2 // Set the desired border width
       
     
   }
@IBAction func cancelButton(_ sender: Any) {
   print("TopCancelButtonTap")
   self.dismissAlert()
   
}
    
    func showTopSideAlert(ofType type: String, title: String, withMessage message: String) {
        print("showAlertMessage called with title: \(title) and message: \(message)")
    
        guard let alertTypeLabel = alertTypeLabel, let alertMessageLabel = alertMessageLabel, let alertTypeImage = alertTypeImage else {
            print("one or more outlets are nil")
            return
        }
        alertTypeLabel.text = title
        alertMessageLabel.text = message
        
        
//        let screenHeight = UIScreen.main.bounds.height
//        topSideAlertView.frame.origin.y = -topSideAlertView.frame.height
        
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: {
                                       self.topSideAlertView.frame.origin.y = 10 })
            switch type {
            case "Success":
                self.alertTypeImage.image = UIImage(named: "topSuccess")
                self.topSideAlertView.backgroundColor = UIColor(named: "successAlertBack")
                self.alertTypeColorLabel.backgroundColor = UIColor(named: "successLabel")
                self.alertTypeLabel.textColor = UIColor(named: "successLabel")
              
            case "Warning":
                self.alertTypeImage.image = UIImage(named: "topWarning")
                self.topSideAlertView.backgroundColor = UIColor(named: "warningAlertBack")
                self.alertTypeColorLabel.backgroundColor = UIColor(named: "warningLabel")
                self.alertTypeLabel.textColor = UIColor(named: "warningLabel")
            case "Failure":
                self.alertTypeImage.image = UIImage(named: "topFailure")
                self.topSideAlertView.backgroundColor = UIColor(named: "failuareAlertBack")
                self.alertTypeColorLabel.backgroundColor = UIColor(named: "failureLabel")
                self.alertTypeLabel.textColor = UIColor(named: "failureLabel")
            default:
                self.alertTypeImage.image = UIImage(named: "defaultImage")
                
                
                
            }
           
        }

    }


    
    func dismissAlert() {
        UIView.animate(withDuration: 0.3, animations: {
            self.mainTopAlertView.frame.origin.y = 20
            self.mainTopAlertView.alpha = 0// Slide the alert view back up
        }) { _ in
            // Hide the alert after the animation
            self.mainTopAlertView.isHidden = true
            
            // Dismiss the alert and remove from the view hierarchy
            self.removeFromParent()  // Remove the view controller from its parent
            self.view.removeFromSuperview()  // Remove the alert's view from the superview
            
            // Optionally, reset the view to its initial state if needed
            self.mainTopAlertView.alpha = 1  // Resetting alpha so that the mainView is visible again in case you reuse it later
        }
        
    }

}

