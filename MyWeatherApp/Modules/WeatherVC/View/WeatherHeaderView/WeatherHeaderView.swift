//
//  WeatherHeaderView.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import UIKit

class WeatherHeaderView: UIView {

    // MARK: - UI Elements
    private let cityLabel = UILabel()
    private let summaryLabel = UILabel()
    private let arrowImageView = UIImageView()


    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        // Configure cityLabel
        cityLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure summaryLabel
        summaryLabel.font = UIFont.systemFont(ofSize: 16)
        summaryLabel.textColor = .gray
        summaryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Configure arrowImageView
        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .gray
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let infoStackView = UIStackView(arrangedSubviews: [cityLabel, summaryLabel])
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.spacing = 4

        let stackView = UIStackView(arrangedSubviews: [infoStackView, arrowImageView])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        
        // Add stackView to header view
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Setup constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configuration
    func configure(city: String?) {
        guard let city, !city.isEmpty else {
            self.cityLabel.text = "no Result"
            self.summaryLabel.isHidden = true
            self.arrowImageView.isHidden = true
            return
        }
        cityLabel.text = city
        summaryLabel.text = "Weather today"
    }

}
