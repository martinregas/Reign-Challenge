//
//  PostListAdapter.swift
//  Reign Challenge
//
//  Created by Martin Regas on 18/10/2020.
//

import UIKit

class GenericAdapter<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}

class PostListAdapter: GenericAdapter<Post> {
    var didSelectItem : ((Post) -> ()) = {_ in}
    var didRemoveItem : ((Post) -> ()) = {_ in}
}

//MARK: UITableViewDataSource
extension PostListAdapter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell {
            cell.selectionStyle = .none
            cell.post = data.value[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            didRemoveItem(data.value[indexPath.row])
        }
    }
}

//MARK: UITableViewDelegate
extension PostListAdapter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectItem(data.value[indexPath.row])
    }
}


