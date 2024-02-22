//
//  BeerCell.swift
//  AlexBeerShop
//
//  Created by Alex on 17.01.2024.
//

import UIKit
import SnapKit
import Kingfisher

final class BeerCell: UITableViewCell {
    // MARK: - Elements
    private let beerImageView: UIImageView = {
        let beerImageView = UIImageView()
        beerImageView.contentMode = .scaleAspectFit
        beerImageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
        }
        return beerImageView
    }()
    private let idLabel: UILabel = {
        let idLabel = UILabel()
        idLabel.textColor = UIColor.orange
        idLabel.text = "ID"
        idLabel.font = .boldSystemFont(ofSize: 12)
        return idLabel
    }()
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "User Name"
        return nameLabel
    }()
    private let descriptionLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Description"
        descLabel.textColor = UIColor.gray
        descLabel.numberOfLines = 3
        return descLabel
    }()
    private lazy var nameStackView: UIStackView = {
        let nameStackView = UIStackView(arrangedSubviews: [idLabel, nameLabel, descriptionLabel])
        nameStackView.axis = .vertical
        nameStackView.alignment = .top
        return nameStackView
    }()
    private lazy var mainStackView: UIStackView = {
        let mainStackView = UIStackView(arrangedSubviews: [beerImageView, nameStackView])
        mainStackView.axis = .horizontal
        mainStackView.distribution = .fill
        mainStackView.spacing = Constants.stackSpacing
        return mainStackView
    }()
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubview()
    }
    required init?(coder: NSCoder) {
        return nil
    }
    // MARK: - Public methods
    func setupView(model: BeerItem) {
        DispatchQueue.main.async {
            self.beerImageView.kf.setImage(with: URL(string: model.imageURL ?? ""))
            self.idLabel.text = String(model.id ?? 0)
            self.nameLabel.text = model.name ?? ""
            self.descriptionLabel.text = model.description ?? ""
        }
    }
    // MARK: - Private methods
    private func setupSubview() {
        addSubview(mainStackView)
        mainStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(Constants.padding)
            make.bottom.equalToSuperview().inset(Constants.padding).priority(.high)
        }
    }
}
// MARK: - Constants
extension BeerCell {
    enum Constants {
        static let stackSpacing: CGFloat = 10.0
        static let padding: CGFloat = 16.0
    }
}


