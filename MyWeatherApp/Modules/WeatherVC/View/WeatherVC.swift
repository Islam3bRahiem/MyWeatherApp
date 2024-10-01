//
//  WeatherVC.swift
//  MyWeatherApp
//
//  Created by Islam Abd El-Rahiem on 01/10/2024.
//

import Combine
import UIKit

class WeatherVC: BaseView<WeatherViewModel> {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Binding
    override
    func bind(viewModel: WeatherViewModel) {
    }
    
    // MARK: - Function
    private
    func setupUI() {
        self.setNavigation()
        self.searchBar.delegate = self
    }
    
    private
    func setNavigation() {
        self.title = "Weather ⛅️"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
        
}


// MARK: - UISearchBar Delegate
extension WeatherVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.inputs.searchBarTextDidChange(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        viewModel.inputs.searchBarSearchButtonClicked(with: searchBar.text)
    }
}
