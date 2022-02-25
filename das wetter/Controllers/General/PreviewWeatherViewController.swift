//
//  PreviewWeatherViewController.swift
//  das wetter
//
//  Created by Matias Kupfer on 21.02.22.
//

import UIKit

class PreviewWeatherViewController: UIViewController {
    
    
    private let weatherCardUIView: UIView = {
        let view = WeatherCardUIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tarragona"
        view.backgroundColor = .red
        view.addSubview(weatherCardUIView)
        configureConstraints()
    }
    

    
    func configureConstraints() {
        let webViewConstraints = [
            weatherCardUIView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            weatherCardUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCardUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCardUIView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
    }
    
    public func configure(with model: OpenWeatherApiResponse) {
//        self.weatherCardUIView.configure(with: model)
    }
    
}
