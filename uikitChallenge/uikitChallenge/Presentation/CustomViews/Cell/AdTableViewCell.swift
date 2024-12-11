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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }

    private func setupViews() {
        view.layer.cornerRadius = 8
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
    }

    func configure(with ad: Ad) {
        titleLabel.text = ad.title
        priceLabel.text = "\(ad.price) \(ad.currency)"
        detailsLabel.text = "\(ad.rooms) hab. · \(ad.size) m²"

        if let url = URL(string: ad.thumbnailUrl) {
            loadImage(from: url)
        }
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
