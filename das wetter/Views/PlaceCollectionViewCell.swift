//
//  PlaceCollectionViewCell.swift
//  das wetter
//
//  Created by Matias Kupfer on 19.02.22.
//

import UIKit

class PlaceCollectionViewCell: UITableViewCell {
    
    static let identifier = "PlaceCollectionViewCell"
    
    private let placeName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperature: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(placeName)
        contentView.addSubview(temperature)
        applyConstraints()
    }
    
    private func applyConstraints() {
        var constraints = [NSLayoutConstraint]()

        constraints.append(placeName.centerYAnchor.constraint(equalTo: self.centerYAnchor))
        constraints.append(placeName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10))

        constraints.append(temperature.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0))
        constraints.append(temperature.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10))
        NSLayoutConstraint.activate(constraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: OpenWeatherApiResponse?) {
        if (model == nil) {
            return
        }
        placeName.text = model!.name + ", " + model!.sys.country
        temperature.text = String(Int(model!.main.temp - 273.15))
    }
    
}
