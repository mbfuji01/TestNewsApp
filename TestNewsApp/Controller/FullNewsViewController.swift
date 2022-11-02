//
//  FullNewsViewController.swift
//  TestNewsApp
//
//  Created by demasek on 01.11.2022.
//

import UIKit

class FullNewsViewController: UIViewController {
    
//MARK: - Variables
    
    private let newsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "Futura-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "Futura-Meduim", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var newsStackView = UIStackView()
    
//MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setConstraints()
    }
    
    private func setupView() {
        
        view.addSubview(newsScrollView)
        newsScrollView.frame = view.frame
        
        newsStackView = UIStackView(arrangedSubviews: [newsImageView,
                                                        titleLabel,
                                                       contentText],
                                     axis: .vertical,
                                     spacing: 10)
        newsScrollView.addSubview(newsStackView)
    }
    
    @objc private func closeButtonTapped() {
        print("closeButtonTapped")
    }
    
    func newsConfigure(title: String, description: String, imageURL: URL){
        titleLabel.text = title
        contentText.text = description
        newsImageView.load(url: imageURL)
    }
    
}

//MARK: - setConstraints

extension FullNewsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newsStackView.topAnchor.constraint(equalTo: newsScrollView.topAnchor, constant: 10),
            newsStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
        ])
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: newsStackView.leadingAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: newsStackView.trailingAnchor, constant: -10),
            newsImageView.widthAnchor.constraint(equalTo: newsStackView.widthAnchor, multiplier: 0.95),
            newsImageView.heightAnchor.constraint(equalTo: newsImageView.widthAnchor, multiplier: 0.57)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: newsStackView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: newsStackView.trailingAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            contentText.leadingAnchor.constraint(equalTo: newsStackView.leadingAnchor, constant: 10),
            contentText.trailingAnchor.constraint(equalTo: newsStackView.trailingAnchor, constant: -10)
        ])
    }
}
