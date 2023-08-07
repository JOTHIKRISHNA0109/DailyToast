//
//  ViewController.swift
//  DailyToastApp
//
//  Created by jothi on 05/08/23.
//

import UIKit

class NewsListViewController: UIViewController {
    
    private let nytNewsResponseUC: NYTNewsResponseUC = NYTNewsResponseUC()
    private var nytNewsResponseArticles : [Article]? = []
    private let refreshControl = UIRefreshControl()
    
    private lazy var newsTableView : UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var loadingImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "loadingImage"))
        return imageView
    }()
    
    private lazy var noNetworkImage : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "noNetwork"))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpNavigationBar()
        showLoadingView()
        fetchNewsArticles()
    }
    
    private func fetchNewsArticles() {
        showLoadingView()
        nytNewsResponseUC.getNewsUC { [self] result in
            switch(result) {
            case .success(let articles):
                DispatchQueue.main.async {
                    self.nytNewsResponseArticles = articles
                    self.hideLoadingView()
                    self.configureView()
                }
            case .failure(_):
                self.showNetworkErrorView()
            }
        }
    }
    
    func setUpNavigationBar() {
        title = "Daily Toast 📰"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureView() {
        setNewsTableView()
        setTableViewDelegates()
    }
    
    private func setNewsTableView() {
        view.addSubview(newsTableView)
        addNewsTableConstraints()
    }
    
    private func setTableViewDelegates() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func addNewsTableConstraints() {
        let newsTableViewConstraints : [NSLayoutConstraint] = [
            newsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            newsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            newsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]
        NSLayoutConstraint.activate(newsTableViewConstraints)
    }
    
    func setLoadingImageViewConstraints() {
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        let loadingImageConstraints : [NSLayoutConstraint] = [
            loadingImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingImage.heightAnchor.constraint(equalToConstant: 300),
            loadingImage.widthAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(loadingImageConstraints)
    }
    
    func setNoNetworkViewConstraints() {
        noNetworkImage.translatesAutoresizingMaskIntoConstraints = false
        let noNetworkImageConstraints : [NSLayoutConstraint] = [
            noNetworkImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noNetworkImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noNetworkImage.heightAnchor.constraint(equalToConstant: 300),
            noNetworkImage.widthAnchor.constraint(equalToConstant: 300)
        ]
        NSLayoutConstraint.activate(noNetworkImageConstraints)

    }
    
    func showNetworkErrorView() {
        view.addSubview(noNetworkImage)
        setNoNetworkViewConstraints()
    }
    
    func showLoadingView() {
        view.addSubview(loadingImage)
        setLoadingImageViewConstraints()
    }
    
    func hideLoadingView() {
        loadingImage.isHidden = true
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let responseCount = nytNewsResponseArticles?.count, nytNewsResponseArticles?.count != 0 else {
            showNetworkErrorView()
            return 0
        }
        return responseCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        cell.setItemInfo(newsItem: nytNewsResponseArticles?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsTableView.deselectRow(at: indexPath, animated: true)
        let newsWebVC = NewsWebViewController()
        newsWebVC.webUrlString = nytNewsResponseArticles?[indexPath.row].web_url ?? ""
        self.navigationController?.pushViewController(newsWebVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}


extension NewsListViewController {

    @objc func refreshData() {
        loadData()
        refreshControl.endRefreshing()
    }
    
    func loadData() {
        fetchNewsArticles()
        newsTableView.reloadData()
    }

}
