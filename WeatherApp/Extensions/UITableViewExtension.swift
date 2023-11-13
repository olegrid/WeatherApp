//
//  UITableViewExtension.swift
//  WeatherApp
//
//  Created by Aleh on 11/11/2023.
//

import Foundation
import UIKit

extension UITableView {

    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
