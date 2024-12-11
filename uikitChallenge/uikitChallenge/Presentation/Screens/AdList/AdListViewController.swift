//
//  ViewController.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import UIKit
import SwiftUI

class AdListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = AdListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Anuncios"
        setupTableView()
        fetchData()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "AdTableViewCell", bundle: nil), forCellReuseIdentifier: "AdTableViewCell")
    }

    private func fetchData() {
        viewModel.fetchAds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showErrorAlert(message: "Failed to load ads: \(error.localizedDescription)")
                }
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AdListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ads.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as? AdTableViewCell else {
            return UITableViewCell()
        }

        let ad = viewModel.ads[indexPath.row]
        cell.configure(with: ad)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAd = viewModel.ads[indexPath.row]
        
        let detailView = AdDetailBuilder().build(propertyCode: selectedAd.propertyCode)
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.title = "Detalle del Anuncio"
        
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

