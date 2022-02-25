//
//  WeatherCardUIView.swift
//  das wetter
//
//  Created by Matias Kupfer on 21.02.22.
//

import UIKit

class WeatherCardUIView: UIView {
    
    private var openWeatherApiResponse: OpenWeatherApiResponse!

    private let placeName: UILabel = {
        let label = UILabel()
        label.text = "Tarragona"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(placeName)
        addSubview(descriptionLabel)
        addSubview(weatherIcon)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configureConstraints() {
    
        var constraints = [NSLayoutConstraint]()

        
        constraints.append(placeName.topAnchor.constraint(equalTo: topAnchor, constant: 20))
        constraints.append(placeName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20))
        
        constraints.append(descriptionLabel.topAnchor.constraint(equalTo: placeName.bottomAnchor, constant: 15))
        constraints.append(descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20))
        constraints.append(descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor))
        
        constraints.append(weatherIcon.centerXAnchor.constraint(equalTo: centerXAnchor))
        constraints.append(weatherIcon.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 25))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public func configure(with model: OpenWeatherApiResponse) {
        
    }
}
