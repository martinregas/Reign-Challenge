//
//  PostTableViewCell.swift
//  Reign Challenge
//
//  Created by Martin Regas on 17/10/2020.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var post : Post? {
        didSet {
            
            guard let post = post else {
                return
            }
            
            setTitle(title: post.title)
            setAuthor(author: post.author)
            setDate(date: post.date)
        }
    }
    
    private func setTitle(title:String?) {
        if let title = title, !title.isEmpty {
            titleLabel?.text = title
        }
        else {
            titleLabel?.text = Post.UNTITLED_POST
        }
    }

    private func setAuthor(author:String?) {
        if let author = author, !author.isEmpty {
            authorLabel?.text = author
        }
        else {
            authorLabel?.text = Post.ANONYMOUS_POST
        }
    }
    
    private func setDate(date:String?) {
        if let date = date, !date.isEmpty {
            dateLabel?.text = Date.formattedDate(isoDate: date).getElapsedInterval()
        }
    }
}
