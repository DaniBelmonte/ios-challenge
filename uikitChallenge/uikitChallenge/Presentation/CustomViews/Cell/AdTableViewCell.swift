//
//  AdTableViewCell.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import UIKit

class AdTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var operationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    @IBOutlet weak var favoriteDateLabel: UILabel!
    private let favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .gray
        return button
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        thumbnailImageView.image = nil

        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .gray

        favoriteButton.removeTarget(nil, action: nil, for: .allEvents)
    }
    private func setupViews() {
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 1

        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true

        operationLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        operationLabel.textColor = .black

        priceLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        priceLabel.textColor = UIColor.systemBlue

        detailsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        detailsLabel.textColor = UIColor.systemGray

        contentView.addSubview(favoriteButton)
        setupFavoriteButtonConstraints()
    }

    private func setupFavoriteButtonConstraints() {
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            favoriteButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 104),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            favoriteButton.widthAnchor.constraint(equalToConstant: 24),
            favoriteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    func configure(with ad: Ad, toggleFavorite: @escaping () -> Void) {
        operationLabel.text = ad.operation
        priceLabel.text = "\(ad.price) \(ad.currency)"
        detailsLabel.text = "\(ad.rooms) hab. · \(ad.size) m²"

        if let url = URL(string: ad.thumbnailUrl) {
            loadImage(from: url)
        }

        favoriteButton.setImage(
            UIImage(systemName: ad.isFavorite ? "heart.fill" : "heart"),
            for: .normal
        )
        favoriteButton.tintColor = ad.isFavorite ? .red : .gray

        if let favoriteDate = ad.favoriteDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
            favoriteDateLabel.text = "Favorited on \(dateFormatter.string(from: favoriteDate))"
            favoriteDateLabel.isHidden = false
        } else {
            favoriteDateLabel.text = nil
            favoriteDateLabel.isHidden = true
        }

        favoriteButton.addAction(UIAction(handler: { _ in
            toggleFavorite()
        }), for: .touchUpInside)
    }

    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self, let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
        }.resume()
    }
}
