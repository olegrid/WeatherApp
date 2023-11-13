//
//  SettingsSceneView.swift
//  WeatherApp
//
//  Created by Aleh on 10/11/2023.
//

import Foundation
import UIKit

protocol SettingsSceneViewProtocol: AnyObject {
    func setupWithPreseter(_ presenter: SettingsScenePresenterProtocol)
    
    func showSearchResults(searchResult: [Location]?, errorText: String?)
    func dismissScene()
}

final class SettingsSceneView: UIViewController, SettingsSceneViewProtocol {
    
    private var presenter: SettingsScenePresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView!
    
    private var locations = [Location]()
    
    func setupWithPreseter(_ presenter: SettingsScenePresenterProtocol) {
        self.presenter = presenter
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let nib = UINib(nibName: "SettingsSceneLocationCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SettingsSceneLocationCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            tableView.setBottomInset(to: keyboardHeight)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        tableView.setBottomInset(to: 0.0)
    }
    
    private func startLoading() {
        loadingView.isHidden = false
        activity.startAnimating()
    }
    
    private func stopLoading() {
        activity.stopAnimating()
        loadingView.isHidden = true
    }
    
    func showSearchResults(searchResult: [Location]?, errorText: String?) {
        if (errorText != nil) || (searchResult == nil) {
            let alert = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            locations.removeAll()
            locations.insert(contentsOf: searchResult!, at: 0)
            tableView.reloadData()
        }
        stopLoading()
    }
    
    func dismissScene() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SettingsSceneView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsSceneLocationCell", for: indexPath)
        if let cell = cell as? SettingsSceneLocationCell {
            let location = locations[indexPath.row]
            cell.cityName.text = location.name
            cell.state.text = location.state
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = locations[indexPath.row]
        presenter?.didSelectLocation(location)
    }
}

extension SettingsSceneView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchLocationsByName(searchText)
    }
}
