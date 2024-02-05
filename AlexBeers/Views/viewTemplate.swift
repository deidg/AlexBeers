//
//  viewTemplate.swift
//  AlexBeers
//
//  Created by Alex on 05.02.2024.
//

import UIKit

class ViewTemplate: UIView {
    // MARK: - Elements
    private let beers: [BeerItem] = []
    let beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        return beerImageView
    }()
    let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        idLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return idLabel
    }()
    let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        return nameLabel
    }()
    let descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.gray
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        return descLabel
    }()
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, descLabel])
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
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupLabels() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.trailing.leading.equalTo(safeAreaLayoutGuide)
        }
    }
}
// MARK: Constants
extension ViewTemplate {
    enum Constants {
        static let nameStackViewstackSpacing : CGFloat = 2.0
        static let mainStackViewstackSpacing: CGFloat = 10.0
        static let padding: CGFloat = 16.0
    }
}
