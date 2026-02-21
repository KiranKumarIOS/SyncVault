//
//  PostDetailViewController.swift
//  SyncVault
//
//  Created by Vedas MacBook Air on 21/02/26.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    var selectedPost: PostEntity?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbltitle.text = selectedPost?.title
        lblBody.text = selectedPost?.body
        setupUI()
        view.backgroundColor = .systemBackground
    }
    private func setupUI() {
        lbltitle.font = .boldSystemFont(ofSize: 24)
        lbltitle.numberOfLines = 0
        
        lblBody.font = .systemFont(ofSize: 17)
        lblBody.textColor = .darkGray
        lblBody.numberOfLines = 0
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
    }
    
}
