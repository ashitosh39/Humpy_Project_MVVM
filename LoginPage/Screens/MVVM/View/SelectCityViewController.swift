//
//  SelectCityViewController.swift
//  LoginPage
//
//  Created by Digitalflake on 07/01/25.
//

import UIKit
import Kingfisher
class SelectCityViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var selectCityCollectionView: UICollectionView!
    
    
    @IBOutlet weak var proceedButton: UIButton!
    
    var selectCityViewModel: SelectCityViewModel?
    var citiesResults : [CitiesResults] = []  // Store the array of Results (Cities)
    
    var selectedCityIndex: IndexPath? // Store the selected row's index path
    var wareHouseViewModel : WareHouseDataViewModel?
    //    var house : [House] = []
    var wareHouses : [WareHouse] = []
    //       private var viewModel: WareHouseDataViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.selectCityViewModel = SelectCityViewModel()
        self.selectCityViewModel?.delegate = self
        self.wareHouseViewModel = WareHouseDataViewModel()
        self.wareHouseViewModel?.delegate = self
        self.selectedCityIndex = nil
        // Start fetching cities
        self.selectCityViewModel?.cityData()
   
        
        self.selectCityCollectionView.delegate = self
        self.selectCityCollectionView.dataSource = self
        
        registerXIBWithTableView()
        
        

        //        wareHouseViewModel?.fetchHouseData()
    }
    func registerXIBWithTableView() {
        let nib = UINib(nibName: "SelectCityCollectionViewCell", bundle: nil)
        self.selectCityCollectionView.register(nib, forCellWithReuseIdentifier: "SelectCityCollectionViewCell")
    }

    
    @IBAction func ProceedButton(_ sender: Any) {
        print("Proceed button pressed")
        
        guard let selectedCityIndex = selectedCityIndex else {
            print("No city selected")
            self.showTopSideAlert(ofType: "Warning", title: "Warning", withMessage: "Please select a city and proceed.")
           
            return
        }
        
        let selectedCity = citiesResults[selectedCityIndex.row]
        print("Selected city index: \(selectedCityIndex.row)")
        
        // Fetch the warehouse data for the selected city
        // We should pass the city ID or related property instead of the entire Results object
        if let cityID = selectedCity.cityID {

        wareHouseViewModel?.fetchWareHouseData(forCityID: cityID)
         
        }
        self.navigateToVerificationViewController()
        self.showTopSideAlert(ofType: "Success", title: "Success", withMessage: "\(selectedCity.cityName ?? "")")

    }
    func navigateToVerificationViewController() {
        // Instantiate the VerificationViewController from storyboard
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            if let dashBoard = self.storyboard?.instantiateViewController(withIdentifier: "DashBoardScreenViewController") as? DashBoardScreenViewController {
                self.navigationController?.pushViewController(dashBoard, animated: true)
            } else {
                print("Error: DashBoardScreenViewController not found.")
            }
            
            // Navigate to the VerificationViewController
            
        }
    }
    
    
    func showTopSideAlert(ofType type: String, title: String, withMessage message: String) {
        DispatchQueue.main.async {
            print("Attempting to show top side alert: \(message)")
            
            // Instantiate the TopAlertViewController from the storyboard
            if let topAlertVC = self.storyboard?.instantiateViewController(withIdentifier: "TopAlertViewController") as? TopAlertViewController {
                
                // Add the TopAlertViewController as a child view controller
                self.addChild(topAlertVC)
                topAlertVC.view.frame = self.view.frame
                self.view.addSubview(topAlertVC.view)
                topAlertVC.didMove(toParent: self)
                
                // Call the showTopSideAlert function on the TopAlertViewController
                topAlertVC.showTopSideAlert(ofType: type, title: title, withMessage: message)
                
                // Automatically dismiss the alert after a few seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    topAlertVC.dismissAlert()
                }
            } else {
                print("Error: TopAlertViewController not found.")
            }
        }
    }
}
extension SelectCityViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesResults.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectCityCollectionViewCell", for: indexPath) as! SelectCityCollectionViewCell
        
        let city = citiesResults[indexPath.row]
        
        cell.cityNameLabel.text = city.cityName
        
        if let imageurlString = city.cityImageURL, let imageUrl = URL(string: imageurlString) {
            cell.cityImage.kf.setImage(with: imageUrl)
        } else {
            cell.cityImage.image = UIImage(named: "defaultImage")
        }
        
        cell.isSelectedCell = indexPath == selectedCityIndex
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCityIndex == indexPath {
            selectedCityIndex = nil
        } else {
            selectedCityIndex = indexPath
        }
        collectionView.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == selectCityCollectionView {
            return CGSize(width: 112, height: 158) // Collection View size
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}

extension SelectCityViewController: SelectCityViewModelDelegate {
    func selectCity(with result: Result<[CitiesResults], Error>) {
        switch result {
        case .success(let cities):
            if cities.isEmpty {
                self.showTopSideAlert(ofType: "Warning", title: "Warning", withMessage: "No cities found")
            } else {
                self.citiesResults = cities// Update the city model data
                print("city successfully fetched: \(cities)")
                UserDefaults.standard.set(citiesResults.first?.cityID, forKey: "cityID")
                DispatchQueue.main.async {
                    self.selectCityCollectionView.reloadData() // Reload the collection view
                    
                }
            }
        case .failure(let error):
            self.showTopSideAlert(ofType: "Failure", title: "Error", withMessage: "Failed to fetch cities: \(error.localizedDescription)")
        }
    }
}

extension SelectCityViewController: WarehouseDataViewModelDelegate {
    func wareHouseDataFetched(with houseResult: Result<[WareHouse], any Error>) {
        switch houseResult {
        case .success(let houses):
            if houses.isEmpty {
                self.showTopSideAlert(ofType: "Warning", title: "Alert", withMessage: "No warehouse data available.")
                
            } else {
                print("Fetched houses: \(houses)")
                UserDefaults.standard.set(houses.first?.warehouseID, forKey: "warehouseID")
                self.navigateToVerificationViewController()
                // Proceed with navigation or other UI updates
            }
        case .failure(let error):
            print("Error fetching house data: \(error.localizedDescription)")
            self.showTopSideAlert(ofType: "Failure", title: "Error", withMessage: "Failed to fetch warehouse data: \(error.localizedDescription)")
        }
    }
}
