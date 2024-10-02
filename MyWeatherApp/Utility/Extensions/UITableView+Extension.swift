////
////  UITableView+Extension.swift
////  MyWeatherApp
////
////  Created by Islam Abd El-Rahiem on 02/10/2024.
////
//
//import UIKit
//
//extension UITableView {
//    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
//            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
//        }
//        return cell
//    }
//
//    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
//        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
//            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
//        }
//        return cell
//    }
//
//    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
//        let identifier = String(describing: name)
//        var bundle: Bundle?
//
//        if let bundleName = bundleClass {
//            bundle = Bundle(for: bundleName)
//        }
//
//        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
//    }
//
//    
//}
