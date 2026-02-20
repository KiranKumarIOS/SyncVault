//
//  PostViewController.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 20/02/26.
//

import UIKit
import CoreData

class PostViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLabel: UILabel!
    
    private let viewModel = PostViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.fetchPosts()
        
    }
    func bindViewModel(){
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            
            self.errorLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] message in
            guard let self = self else { return }
            
            self.errorLabel.text = message
            self.errorLabel.isHidden = false
            self.tableView.isHidden = true
        }
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let posts = viewModel.posts[indexPath.row]
        cell.textLabel?.text = posts.title
        cell.detailTextLabel?.text = posts.body
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.detailTextLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .gray
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
