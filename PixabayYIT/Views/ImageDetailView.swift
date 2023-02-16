//
//  ImageDetailView.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 16/02/2023.
//

import UIKit

class ImageDetailView: UIView {
    let viewModel: ImageDetailViewViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tagsLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let likesLabel: UILabel = {
       let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect, viewModel: ImageDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        viewModel.delegate = self
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(mainImageView, userImageView, userNameLabel, tagsLabel, likesLabel)
        addConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: widthAnchor),
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            mainImageView.heightAnchor.constraint(equalToConstant: viewModel.imageHeight),
            
            userImageView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 20),
            userImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            userImageView.widthAnchor.constraint(equalToConstant: 60),
            userImageView.heightAnchor.constraint(equalToConstant: 60),
            
            userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 20),
            userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            userNameLabel.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor),
            
            tagsLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 20),
            tagsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            tagsLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            likesLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 10),
            likesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            likesLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
        ])
    }
    
    private func setupViews() {
        tagsLabel.text = viewModel.tags
        userNameLabel.text = viewModel.user
        likesLabel.text = viewModel.likes
    }
}

extension ImageDetailView: ImageDetailViewViewModelDelegate {
    func userImageFetched(with data: Data) {
        userImageView.image = UIImage(data: data)
        
    }
    
    func mainImageFetched(with data: Data) {
        mainImageView.image = UIImage(data: data)
    }
}
