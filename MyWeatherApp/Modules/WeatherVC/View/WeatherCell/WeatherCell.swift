//
//  WeatherCell.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 02/10/2024.
//

import UIKit

class WeatherCell: UITableViewCell {

    private let dayLabel = UILabel()
    private let monthLabel = UILabel()
    private let conditionLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let temperatureLabel = UILabel()
    
    var viewModel: DailyWeatherRowViewModel? {
        didSet {
            self.configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        dayLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        monthLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        conditionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .gray
        temperatureLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        let dateStackView = UIStackView(arrangedSubviews: [dayLabel, monthLabel])
        dateStackView.axis = .vertical
        dateStackView.alignment = .center
        dateStackView.spacing = 4

        let conditionStackView = UIStackView(arrangedSubviews: [conditionLabel, descriptionLabel])
        conditionStackView.axis = .vertical
        conditionStackView.alignment = .leading
        conditionStackView.spacing = 4
        
        let leftStackView = UIStackView(arrangedSubviews: [dateStackView, conditionStackView])
        leftStackView.axis = .horizontal
        leftStackView.spacing = 25

        let stackView = UIStackView(arrangedSubviews: [leftStackView, temperatureLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private
    func configure() {
        dayLabel.text = viewModel?.day
        monthLabel.text = viewModel?.month
        conditionLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.fullDescription
        temperatureLabel.text = viewModel?.temperature
    }
}
