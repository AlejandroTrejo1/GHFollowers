//
//  UITableView+EXT.swift
//  GHFollowers
//
//  Created by Alejandro Trejo on 21/08/21.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
