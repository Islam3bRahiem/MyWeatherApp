//
//  CityDetailsVC.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 03/10/2024.
//

import Combine
import UIKit

class CityDetailsVC: BaseView<CityDetailsViewModel> {

    // MARK: - Outlets
    @IBOutlet weak var maxTemperatureLbl: UILabel!
    @IBOutlet weak var minTemperatureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!

    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.inputs.viewDidLoad()
    }

    // MARK: - Binding
    override
    func bind(viewModel: CityDetailsViewModel) {
        viewModel.outputs.citySubject
            .sink { [weak self] city in
                guard let self else { return }
                self.maxTemperatureLbl.text = city?.maxTemperature
                self.minTemperatureLbl.text = city?.minTemperature
                self.humidityLbl.text = city?.humidity
                self.windSpeedLbl.text = "22 KM/S"
            }
            .store(in: &cancellable)
    }
}
