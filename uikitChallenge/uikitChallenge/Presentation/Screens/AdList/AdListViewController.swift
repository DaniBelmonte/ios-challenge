//
//  ViewController.swift
//  uikitChallenge
//
//  Created by Daniel Belmonte Valero on 11/12/24.
//

import UIKit
import SwiftUI

class AdListViewController: UIViewController {
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Properties
    private let viewModel = AdListViewModel()
    private let refreshControl = UIRefreshControl()

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ads_title".localized
        setupRefreshControl()
        setupTableView()
        fetchData()
    }
    
    //MARK: Functions
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "loading_text".localized)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    
    @objc private func refreshData() {
        viewModel.fetchAds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showErrorAlert(message: String(format: "error_alert_message".localized, error.localizedDescription))
                }
                self?.refreshControl.endRefreshing()
            }
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "AdTableViewCell", bundle: nil), forCellReuseIdentifier: "AdTableViewCell")
        tableView.accessibilityIdentifier = "MainTable"
    }

    private func fetchData() {
        viewModel.fetchAds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.tableView.reloadData()
                case .failure(let error):
                    self?.showErrorAlert(message: String(format: "error_alert_message".localized, error.localizedDescription))
                }
            }
        }
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "error_alert_title".localized, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok_button".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showFavsAlert() {
        let alert = UIAlertController(title: "favorites_updated_title".localized, message: "favorites_updated_message".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok_button".localized, style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

//MARK: Extension UITableViewDelegate, UITableViewDataSource
extension AdListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ads.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell", for: indexPath) as? AdTableViewCell else {
            return UITableViewCell()
        }

        let ad = viewModel.ads[indexPath.row]
        cell.configure(with: ad) { [weak self] in
            self?.viewModel.toggleFavorite(for: ad) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        self?.showFavsAlert()
                    case .failure(let error):
                        self?.showErrorAlert(message: String(format: "error_alert_message".localized, error.localizedDescription))
                    }
                }
            }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAd = viewModel.ads[indexPath.row]
        
        let detailView = AdDetailBuilder().build(propertyCode: selectedAd.propertyCode)
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.title = "ad_detail_title".localized
        
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
