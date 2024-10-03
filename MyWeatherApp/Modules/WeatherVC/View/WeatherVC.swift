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
    let searchBar = UISearchBar()
    let tableView = UITableView()

    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Binding
    override
    func bind(viewModel: WeatherViewModel) {
        viewModel.outputs.reloadTableView
            .sink { [weak self] _ in
                guard let self else { return }
                self.tableView.reloadData()
            }
            .store(in: &cancellable)
        
        viewModel.outputs.navigateToDetailsScreen
            .sink { [weak self] isEnabled in
                guard let self, isEnabled else { return }
                self.coordinator.weather.navigate(to: .cityDetails(searchBar.text ?? ""), with: .push)
            }
            .store(in: &cancellable)

    }
    
    // MARK: - Function
    private
    func setupUI() {
        self.setupSearchBar()
        self.setupTableView()
        self.setNavigation()
        self.searchBar.delegate = self
    }
    
    private
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search for weather..."
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
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

extension WeatherVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.outputs.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherCell
        cell.viewModel = self.viewModel.outputs.cellViewModel(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = WeatherHeaderView()
        headerView.configure(city: searchBar.text)
        headerView.headerTappedAction = {
            self.viewModel.inputs.didTapOnHeaderSection()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}
