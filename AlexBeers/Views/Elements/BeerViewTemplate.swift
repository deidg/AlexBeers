//
//  viewTemplate.swift
//  AlexBeers
//
//  Created by Alex on 05.02.2024.
//

import UIKit
import Kingfisher

class BeerViewTemplate: UIView {
    // MARK: - Elements
    private let beers: [BeerItem] = []
    private let beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        return beerImageView
    }()
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.font = .boldSystemFont(ofSize: 20)
        return idLabel
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    private let descriptionLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.gray
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        return descLabel
    }()
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, descriptionLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .center
        nameStackView.spacing = Constants.nameStackViewstackSpacing
        return nameStackView
    }()
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView(arrangedSubviews: [beerImageView, nameStackView])
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = Constants.mainStackViewstackSpacing
        return mainStackView
    }()
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabels()
    }
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupLabels() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalTo(safeAreaLayoutGuide).inset(10)
        }
    }
    
    func configureView(imageLink: String, id: Int, name: String, description: String ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let imageURL = URL(string: imageLink)
            beerImageView.kf.setImage(with: imageURL)
            idLabel.text = "\(id)"
            nameLabel.text = name
            descriptionLabel.text = description
        }
    }
}
// MARK: - Constants
extension BeerViewTemplate {
    enum Constants {
        static let idLabelFontSize: CGFloat = 15.0
        static let nameStackViewstackSpacing: CGFloat = 2.0
        static let mainStackViewstackSpacing: CGFloat = 10.0
        static let padding: CGFloat = 16.0
    }
}
