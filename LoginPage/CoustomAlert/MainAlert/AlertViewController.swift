//
//  AlertViewController.swift
//  LoginPage
//
//  Created by Digitalflake on 13/01/25.
//

import UIKit
protocol AlertViewControllerDelegate: AnyObject {
    func didPressDeleteButton()
}

class AlertViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var subAlertView: UIView!
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    private var isAlertViewLaiOut : Bool = false
    
    
    weak var delegate: AlertViewControllerDelegate?  // The delegate property
    override func viewDidLoad() {
        super.viewDidLoad()
       
        subAlertView.layer.cornerRadius = 20
        subAlertView.clipsToBounds = true
    
        //        mainView.alpha = 0.5
    }
  
    
   
    
    @IBAction func deleteButton(_ sender: Any) {
        delegate?.didPressDeleteButton()
        dismissAlert()
        }

        
    
    
    @IBAction func cancelAlert(_ sender: UIButton) {
        print("CancelButtonTap")
        
        self.dismissAlert()
    }
    
   
    func showAlertMessage(ofType type: String, title: String, message: String, showDeleteButton : Bool = false)  {
            print("showAlertMessage called with title: \(title) and message: \(message)")
            
            guard let alertLabel = alertLabel, let messageLabel = messageLabel, let alertImage = alertImage else {
                print("One or more outlets are nil")
                return
            }
            
            alertLabel.text = title
            messageLabel.text = message
            
        
        deleteButton.isHidden = !showDeleteButton
            DispatchQueue.main.async {
                switch type {
                case "Success":
                    alertImage.image = UIImage(named: "success")
                    self.subAlertView.layer.borderColor = UIColor(named: "successBorder")?.cgColor
                case "Warning":
                    alertImage.image = UIImage(named: "warning")
                    self.subAlertView.layer.borderColor = UIColor(named: "warningBorder")?.cgColor
                    self.deleteButton.layer.cornerRadius = 5
                    self.deleteButton.layer.backgroundColor = UIColor(named: "warningBorder")?.cgColor
                case "Failure":
                    alertImage.image = UIImage(named: "failure")
                    self.subAlertView.layer.borderColor = UIColor(named: "failureBorder")?.cgColor
                default:
                    alertImage.image = UIImage(named: "error")
                    
                }
                self.subAlertView.layer.borderWidth = 2
            }
            
            
        }
        func dismissAlert() {
            UIView.animate(withDuration: 2, animations: {
                
            }) { _ in
                self.mainView.alpha = 0
                self.mainView.isHidden = true
                
                self.removeFromParent()
                self.view.removeFromSuperview()
                
                self.mainView.alpha = 1
            }
        }
    }

