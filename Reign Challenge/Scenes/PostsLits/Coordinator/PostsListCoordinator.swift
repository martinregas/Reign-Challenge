//
//  PostsListCoordinator.swift
//  Reign Challenge
//
//  Created by Martin Regas on 20/10/2020.
//

import UIKit

final class PostsListCoordinator: BaseCoordinator {
    private var presenter: UINavigationController
    private var postsListViewController: PostsListViewController?
    private var postDetailCoordinator: PostDetailCoordinator?
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
}

//MARK: Coordinator
extension PostsListCoordinator: Coordinator {
    func start() {
        let postListViewController = PostsListViewController(nibName: "PostsListViewController", bundle: nil)
        postListViewController.postListVCDelegate = self
        self.postsListViewController = postListViewController
        self.addLogoInNavBar(to: postListViewController)
        presenter.pushViewController(postListViewController, animated: true)
    }
}

//MARK: PostsListVCDelegate
extension PostsListCoordinator: PostsListVCDelegate {
    func postsListVC(_ controller: PostsListViewController, didSelect post: Post) {
        let postDetailCoordinator = PostDetailCoordinator(presenter: presenter, post: post)
        self.postDetailCoordinator = postDetailCoordinator
        postDetailCoordinator.start()
    }
}
