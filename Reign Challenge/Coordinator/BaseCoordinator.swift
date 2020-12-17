//
//  BaseCoordinator.swift
//  Reign Challenge
//
//  Created by Martin Regas on 20/10/2020.
//

import UIKit

class BaseCoordinator {
    func addLogoInNavBar(to
        viewController: UIViewController) {
        let logo = UIImageView.init(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 20))
        logo.image = UIImage(named: "logo")?.withRenderingMode(.alwaysOriginal)
        let item = UIBarButtonItem(customView: logo)
        
        let currWidth = item.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = item.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        viewController.navigationItem.rightBarButtonItem = item
    }
}
