//
//  WeatherViewController.swift
//  das wetter
//
//  Created by Matias Kupfer on 19.02.22.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    
    public var openWeatherApiResponse: OpenWeatherApiResponse?
    var newSafeArea = UIEdgeInsets()
    var routeCoordinates: [CLLocation] = []
    
    private var weatherView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search a location.. eg: London"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    public let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search a location.. eg: London"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let placeName: UILabel = {
        let label = UILabel()
        label.text = "Select a city."
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Search for a city to check the weather."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "sun.min", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        return imageView
    }()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.overrideUserInterfaceStyle = .dark
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        title = "Weather"
        
        let appearance = UINavigationBarAppearance()
        //appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .purple
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        
        navigationItem.searchController = searchController
        
        view.addSubview(searchBar)
        view.addSubview(weatherView)
        weatherView.addSubview(placeName)
        weatherView.addSubview(descriptionLabel)
        weatherView.addSubview(weatherIcon)
        weatherView.addSubview(mapView)
        
        
        searchController.searchResultsUpdater = self
        configureConstraints()
    }
    
    private func configureConstraints() {
        
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(weatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(weatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(weatherView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(weatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        
        
        
        constraints.append(placeName.topAnchor.constraint(equalTo: weatherView.topAnchor, constant: 20))
        constraints.append(placeName.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: 20))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor))
        
        constraints.append(weatherIcon.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor))
        constraints.append(weatherIcon.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25))
        
        constraints.append(mapView.centerXAnchor.constraint(equalTo: weatherView.centerXAnchor))
        constraints.append(mapView.centerYAnchor.constraint(equalTo: weatherView.centerYAnchor))
        constraints.append(mapView.widthAnchor.constraint(equalTo: weatherView.widthAnchor))
        constraints.append(mapView.heightAnchor.constraint(equalToConstant: 200))
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension WeatherViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        // remove white spaces and >= than 3 characters
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? SearchResultsViewController else {
                  return
              }
        
        resultsController.delegate = self
        
        WeatherApiService.shared.getWeatherByCity(with: query) {result in
            DispatchQueue.main.async {
                switch result {
                case .success(let openWeatherApiResponse):
                    resultsController.openWeatherApiResponse = openWeatherApiResponse
                    resultsController.searchResultsTable.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func searchResultsViewControllerDidTapItem(_ viewModel: OpenWeatherApiResponse) {
        print("XD?")
        //        let vc = PreviewWeatherViewController()
        //        vc.configure(with: viewModel)
        //self.navigationController?.pushViewController(vc, animated: true)
        openWeatherApiResponse = viewModel
        placeName.text = viewModel.name
        descriptionLabel.text = String(Int(viewModel.main.temp - 273.15))
        let startMarker = MKPointAnnotation()
        startMarker.title = viewModel.name
        let coord = CLLocationCoordinate2D(latitude: viewModel.coord.lat, longitude: viewModel.coord.lon)
        startMarker.coordinate = coord
        mapView.centerCoordinate = coord
        mapView.addAnnotation(startMarker)
        let zoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 0,maxCenterCoordinateDistance: 100000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
        searchController.isActive = false
    }
}

extension WeatherViewController : MKMapViewDelegate {
    
}

