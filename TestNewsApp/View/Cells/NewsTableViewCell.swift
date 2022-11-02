//
//  NewsTableViewCell.swift
//  TestNewsApp
//
//  Created by demasek on 31.10.2022.
//

import UIKit

//MARK: - CellModel

class NewsTableViewCellModel {
    let title: String
    var imageURL: URL?
    let publishedAt: String
    let content: String
    
    init(title: String,
         imageURL: URL?,
         publishedAt: String,
         content: String,
         textURL: String
    ) {
        self.title = title
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        self.content = content
    }
}

class NewsTableViewCell: UITableViewCell {
    
//MARK: - Variables
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.image = UIImage(named: "")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
//        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Солнце светит я сияю"
        label.font = UIFont(name: "Futura-medium", size: 17)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "5 минут назад"
        label.font = UIFont(name: "Futura-medium", size: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        newsImageView.image = nil
        timeLabel.text = nil
    }
    
    private func setupView() {
        
        backgroundColor = .white
        selectionStyle = .none
        
        addSubview(newsTitleLabel)
        addSubview(timeLabel)
        addSubview(newsImageView)
    }
    
    func configure(with viewModel: NewsTableViewCellModel) {
        newsTitleLabel.text = viewModel.title
        timeLabel.text = viewModel.publishedAt
        
        // Image
        if let url = viewModel.imageURL {
            newsImageView.load(url: url)
        } else if let url = viewModel.imageURL {
            // Fetch
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let url = data, error == nil else {
                    return
                }
                let str = String(decoding: url, as: UTF8.self)
                viewModel.imageURL = URL(string: str)
                DispatchQueue.main.async {
                    self?.newsImageView.load(url: URL(string: str)!)
                }
            }.resume()
        }
    }
}

//MARK: - setConstraints

extension NewsTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newsTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            newsTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.leadingAnchor, constant: -3)
        ])
        newsTitleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        newsTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 5),
            timeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3),
            timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
        timeLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        timeLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
//        let timeBottomConstraint = timeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
//        timeBottomConstraint.priority = UILayoutPriority(400)
//        timeBottomConstraint.isActive = true
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            newsImageView.leadingAnchor.constraint(equalTo: newsTitleLabel.trailingAnchor, constant: 3),
//            newsImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            newsImageView.widthAnchor.constraint(equalToConstant: 100),
            newsImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        let newsImageViewConstraint = newsImageView.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -3)
        newsImageViewConstraint.priority = UILayoutPriority(500)
        newsImageViewConstraint.isActive = true
    }
}
