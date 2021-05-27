//
//  ViewController.swift
//  IntroToRxSwift
//
//  Created by Noshaid Ali on 26/05/2021.
//

import UIKit
import RxSwift
import RxCocoa

//whenever items changes tableView automatically updates

struct Product {
    let imageName: String
    let title: String
}

struct ProductViewModel {
    var items = PublishSubject<[Product]>()
    
    var products = [
        Product(imageName: "house", title: "Home"),
        Product(imageName: "gear", title: "Settings"),
        Product(imageName: "person.circle", title: "Profile"),
        Product(imageName: "airplane", title: "Flights")
    ]
    
    func fetchItems() {
        items.onNext(products)
        //items.onCompleted()
    }
    
    mutating func addMoreItems() {
        let product = [
            Product(imageName: "bell", title: "Activity")
        ]
        products.append(contentsOf: product)
        items.onNext(products)
        items.onCompleted()
    }
}

class ViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var viewModel = ProductViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        bindTableView()
    }
    
    func bindTableView() {
        //Bind items to tableView
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, model, cell in
            cell.textLabel?.text = model.title
            cell.imageView?.image = UIImage(systemName: model.imageName)
        }.disposed(by: bag)
        
        //Bind a model selected handler
        tableView.rx.modelSelected(Product.self).bind { (product) in
            print(product.title)
            self.viewModel.addMoreItems()
        }.disposed(by: bag)
        
        //fetch items
        viewModel.fetchItems()
    }
    
}

