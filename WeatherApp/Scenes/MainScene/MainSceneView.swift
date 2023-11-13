//
//  MainSceneView.swift
//  WeatherApp
//
//  Created by Aleh on 08/11/2023.
//

import Foundation
import UIKit

protocol MainSceneViewProtocol: AnyObject {
    
    func setupWithPreseter(_ presenter: MainScenePresenterProtocol)
    func setupLocationSegmentedControl(isHidden: Bool, settings: PreferableLocationSetting)
    func setupMeasurmentSegmentControl(measurment: MeasurementT)
    
    func showDataInView(locationString: String?, tempertureString: String?, errorString: String?)
    
}

class MainSceneView: UIViewController, MainSceneViewProtocol {
    
    private var presenter: MainScenePresenterProtocol?
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var tempertureLabel: UILabel!
    @IBOutlet weak var selectLocationTypeSegmentControl: UISegmentedControl!
    @IBOutlet weak var measurmentSegmentControl: UISegmentedControl!
    
    func setupWithPreseter(_ presenter: MainScenePresenterProtocol) {
        self.presenter = presenter
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        presenter?.viewReadyForData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func didBecomeActive() {
        presenter?.viewReadyForData()
    }
    
    func setupLocationSegmentedControl(isHidden: Bool, settings: PreferableLocationSetting) {
        selectLocationTypeSegmentControl.isHidden = isHidden
        if settings == .currentLocation {
            selectLocationTypeSegmentControl.selectedSegmentIndex = 0
        } else {
            selectLocationTypeSegmentControl.selectedSegmentIndex = 1
        }
    }
    
    func setupMeasurmentSegmentControl(measurment: MeasurementT) {
        if measurment == .MeasurementC {
            measurmentSegmentControl.selectedSegmentIndex = 0
        } else {
            measurmentSegmentControl.selectedSegmentIndex = 1
        }
    }
    
    func showDataInView(locationString: String?, tempertureString: String?, errorString: String?) {
        
        if let errorString = errorString {
            let alert = UIAlertController(title: "Error", message: errorString, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            
            return
        }
        if let tempertureString = tempertureString, let locationString = locationString {
            locationNameLabel.text = locationString
            tempertureLabel.text = tempertureString
        }
    }
    
    @IBAction func onSelectLocationButton() {
        presenter?.selectLocation()
    }
    
    @IBAction func onChangeLocationType(sender: UISegmentedControl) {
        if selectLocationTypeSegmentControl.selectedSegmentIndex == 0 {
            presenter?.changeSelectedLocationType(setting: .currentLocation)
        } else {
            presenter?.changeSelectedLocationType(setting: .selectedLocation)
        }
    }
    
    @IBAction func onChangeMeasurment(sender: UISegmentedControl) {
        if measurmentSegmentControl.selectedSegmentIndex == 0 {
            presenter?.changeSelectedMeasurment(measurment: .MeasurementC)
        } else {
            presenter?.changeSelectedMeasurment(measurment: .MeasurementF)
        }
    }
    
}
