//
//  AppCoordinator.swift
//  Reign Challenge
//
//  Created by Martin Regas on 20/10/2020.
//

import UIKit

final class AppCoordinator: BaseCoordinator, Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var postListCoordinator: PostsListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        rootViewController.navigationBar.tintColor = .black
        postListCoordinator = PostsListCoordinator(presenter: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        postListCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
