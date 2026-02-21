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
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = PostViewModel()
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var filteredPosts: [PostEntity] = []
    private var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        viewModel.fetchPosts()
    
        setupUtilities()
        setupSearchBarAppearance()
        
    }
    func setupUtilities(){
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        tableView.refreshControl = refreshControl
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        searchBar.placeholder = "Search by title"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.layer.cornerRadius = 8
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = UIColor.lightGray.cgColor
    }
    func setupSearchBarAppearance() {
        
        // Remove ALL default styling
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.backgroundImage = UIImage()
        searchBar.isTranslucent = false
        searchBar.backgroundColor = .clear
        
        let customColor = UIColor.systemGray6
        
        if let textField = searchBar.searchTextField as UITextField? {
            textField.backgroundColor = customColor
            textField.layer.cornerRadius = 10
            textField.layer.masksToBounds = true
        }
    }
    
    func bindViewModel(){
        viewModel.onDataUpdated = { [weak self] in
            guard let self = self else { return }
            
            self.refreshControl.endRefreshing()
            self.errorLabel.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        
        viewModel.onError = { [weak self] message in
            guard let self = self else { return }
            
            self.refreshControl.endRefreshing()
            self.errorLabel.text = message
            self.errorLabel.isHidden = false
            self.tableView.isHidden = true
        }
        viewModel.onLoading = { [weak self] isLoading in
            guard let self = self else { return }
            
            if isLoading {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    @objc private func refreshPosts() {
        viewModel.fetchPosts()
    }
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredPosts.count : viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        let posts = isSearching ? filteredPosts[indexPath.row] : viewModel.posts[indexPath.row]
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
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}

extension PostViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            isSearching = false
            errorLabel.isHidden = true
            tableView.isHidden = false
        } else {
            isSearching = true
            filteredPosts = viewModel.posts.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
            if filteredPosts.isEmpty {
                errorLabel.text = "No Results Found"
                errorLabel.isHidden = false
                tableView.isHidden = true
            } else {
                errorLabel.isHidden = true
                errorLabel.text = ""
                tableView.isHidden = false
            }
        }
        
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text?.trimmingCharacters(in: .whitespaces) ?? ""
        
        if text.isEmpty {
            isSearching = false
            tableView.reloadData()
            errorLabel.isHidden = true
            tableView.isHidden = false
        }
        searchBar.resignFirstResponder()
    }
}
