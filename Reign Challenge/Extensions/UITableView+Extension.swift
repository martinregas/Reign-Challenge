//
//  String+Constants.swift
//  Reign Challenge
//
//  Created by Martin Regas on 21/10/2020.
//

import UIKit

extension UITableView {
    func registerNibForCellClass(_ cellClass: UITableViewCell.Type) {
        let cellReuseIdentifier = cellClass.cellReuseIdentifier()
        let nibCell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        register(nibCell, forCellReuseIdentifier: cellReuseIdentifier)
    }
}
