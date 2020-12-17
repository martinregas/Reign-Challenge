//
//  PostDetailCoordinator.swift
//  Reign Challenge
//
//  Created by Martin Regas on 20/10/2020.
//

import UIKit

final class PostDetailCoordinator: BaseCoordinator {
    private var presenter: UINavigationController
    private var postDetailViewController: PostDetailViewController?
    private let post: Post
    
    init(presenter: UINavigationController, post: Post) {
        self.presenter = presenter
        self.post = post
    }
}


//MARK: Coordinator
extension PostDetailCoordinator: Coordinator {
    func start() {
        let postDetailViewController = PostDetailViewController(nibName: "PostDetailViewController", bundle: nil)
        let viewModel = PostDetailViewModel(post: post)
        postDetailViewController.setViewModel(viewModel: viewModel)
        self.addLogoInNavBar(to: postDetailViewController)
        self.postDetailViewController = postDetailViewController
        presenter.pushViewController(postDetailViewController, animated: true)
    }
}
