//
//  PostsListViewController.swift
//  Reign Test
//
//  Created by Martin Regas on 17/10/2020.
//

import UIKit

protocol PostsListVCDelegate: class {
    func postsListVC(_ controller: PostsListViewController, didSelect post: Post)
}

class PostsListViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    weak var postListVCDelegate: PostsListVCDelegate?

    let adapter = PostListAdapter()
    
    lazy var viewModel : PostsListViewModel = {
        let viewModel = PostsListViewModel(adapter: adapter)
        return viewModel
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getPosts), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.viewModel.getTitle()
                
        self.tableView.registerNibForCellClass(PostTableViewCell.self)
        
        self.tableView.dataSource = self.adapter
        self.tableView.delegate = self.adapter
        self.tableView.refreshControl = self.refreshControl
        
        let spinner = self.displaySpinner(onView: self.view)
        
        self.adapter.data.addAndNotify(observer: self) { [weak self] _ in
            if let strSelf = self {
                strSelf.reloadData(spinner: spinner)
            }
        }
        
        self.viewModel.requestError = { error in
            self.showErrorAlert(error: error, spinner: spinner)
        }
        
        self.adapter.didSelectItem = { item in
            if item.url == nil {
                self.showErrorAlert(error: "Post URL not found", spinner: spinner)
                return
            }
            
            self.postListVCDelegate?.postsListVC(self, didSelect: item)
        }
        
        self.adapter.didRemoveItem = { item in
            self.viewModel.removeItem(post: item)
        }
        
        self.getPosts()
    }
    
    @objc func getPosts() {
        self.viewModel.getPosts()
    }
    
    func reloadData(spinner:UIView) {
        if refreshControl.isRefreshing {refreshControl.endRefreshing()}
        tableView.reloadData()
        removeSpinner(spinner: spinner)
    }
    
    func showErrorAlert(error:String, spinner:UIView) {
        if refreshControl.isRefreshing {refreshControl.endRefreshing()}
        removeSpinner(spinner: spinner)
        let alert = showAlertWith(message: error)
        present(alert, animated: true, completion: nil)
    }
}


