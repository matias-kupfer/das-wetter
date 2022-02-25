//
//  SearchViewController.swift
//  das wetter
//
//  Created by Matias Kupfer on 19.02.22.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTapItem(_ viewModel: OpenWeatherApiResponse)
}


class SearchResultsViewController: UIViewController {
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public var openWeatherApiResponse: OpenWeatherApiResponse!
    
    public let searchResultsTable: UITableView = {
        let table = UITableView()
        table.register(PlaceCollectionViewCell.self, forCellReuseIdentifier: PlaceCollectionViewCell.identifier)
        return table
    }()
    
    /*private let ctaButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitle("click bitch", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .red
        button.addTarget(self, action: #selector(SearchResultsViewController.onctaclick(_:)), for: .touchUpInside)
        return button
    }()
    
    @objc func onctaclick(_: UIButton) {
        print("hola")
        let vc = PreviewWeatherViewController()
        //vc.configure(with: self.openWeatherApiResponse)
        self.navigationController?.pushViewController(vc, animated: true)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(searchResultsTable)
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
        
        configureConstraints()
    }
    
    private func configureConstraints() {
    
        var constraints = [NSLayoutConstraint]()
        

        
        NSLayoutConstraint.activate(constraints)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultsTable.frame = view.bounds
    }
    
    
}

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceCollectionViewCell.identifier, for: indexPath) as? PlaceCollectionViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: openWeatherApiResponse)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.searchResultsViewControllerDidTapItem(openWeatherApiResponse)
    }
}

