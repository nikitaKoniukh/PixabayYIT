//
//  ImageDetailViewController.swift
//  PixabayYIT
//
//  Created by Nikita Koniukh on 16/02/2023.
//

import UIKit

class ImageDetailViewController: UIViewController {

    private var viewModel: ImageDetailViewViewModel
    private let detailView: ImageDetailView
    
    init(viewModel: ImageDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = ImageDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
    }

}
