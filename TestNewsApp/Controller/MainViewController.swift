//
//  ViewController.swift
//  TestNewsApp
//
//  Created by demasek on 31.10.2022.
//

import UIKit

class MainViewController: UIViewController {
    
//MARK: - Variables
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Demasek Newsday"
        label.textColor = .black
        label.font = UIFont(name: "Futura-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.bounces = false
//        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idTableViewCell = "idTableViewCell"
    let newsVC = FullNewsViewController()
    private var viewModels = [NewsTableViewCellModel]()
    private var articles = [Article]()
    
//MARK: - Life Cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight =  UITableView .automaticDimension
        tableView.estimatedRowHeight =  100
        
        APICaller.shared.getStories { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellModel(
                        title: $0.title,
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        publishedAt: $0.publishedAt,
                        content: $0.publishedAt,
                        textURL: $0.description
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        setupView()
        setConstraints()
        setDelegates()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }

    private func setupView() {
        
        view.backgroundColor = #colorLiteral(red: 0.9450981021, green: 0.9450981021, blue: 0.9450981021, alpha: 1)
        
        view.addSubview(mainTitleLabel)
        view.addSubview(tableView)
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

//MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell,
                                                 for: indexPath) as! NewsTableViewCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let imageURL = URL(string: article.urlToImage ?? "") else {
            return
        }
        newsVC.newsConfigure(title: article.title, description: article.description, imageURL: imageURL)
        let vc = newsVC
        present(vc, animated: true)
    }
}

//MARK: - setConstraints

extension MainViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

struct Schedule: Decodable {
    let valueFrom: String?
    let valueTo: String?
    let id: String?
    let name: String?
  var valueFromDate: Date {
    guard let value = valueFrom else { return Date() }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return dateFormatter.date(from:value) ?? Date()
  }
  var valueToDate: Date {
    guard let value = valueTo else { return Date() }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return dateFormatter.date(from:value) ?? Date()
  }

  var idString: String {
    id ?? UUID().uuidString
  }
  var nameString: String {
    name ?? ""
  }
}
