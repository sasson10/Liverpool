//
//  ProductosViewController.swift
//  LiverpoolTest
//
//  Created by Eon Igniting on 19/06/21.
//

import UIKit

class ProductosViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var products : [Producto] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getProducts(product: "estufa")
        
    }
    
    
    func getProducts(product : String){
        self.showSpinner(onView: self.view)
        LiverpoolAPI.getProducts(product: product) { (result) in
            switch result {
                case .success(let response):
                    self.removeSpinner()
                    print(response)
                    self.products = response.plpResults.records
                    self.tableView.reloadData()
                case .failure(let error):
                    self.removeSpinner()
                    print("ContractsViewController: An error occured \(error)")
            }
        }
    }

}

extension ProductosViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductTableViewCell
        
        if let url = URL(string: self.products[indexPath.row].smImage){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let data = data{
                        cell.productImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        let priceWithoutDiscount = self.products[indexPath.row].maximumListPrice
        let priceWithDiscount = self.products[indexPath.row].maximumPromoPrice
        
        cell.nameProduct.text = self.products[indexPath.row].productDisplayName
        cell.priceWithoutDicount.text = "\(priceWithoutDiscount)"
        cell.priceWithDiscount.text = "\(priceWithDiscount)"
//        cell.productImage.image = self.products[indexPath.row].imagenProducto
//        cell.nameProduct.text = self.products[indexPath.row].nombreProducto
//        cell.priceWithoutDicount.text = self.products[indexPath.row].precioSinDescuentoProducto
//        cell.priceWithDiscount.text = self.products[indexPath.row].precioConDescuentoProducto
        
        
        return cell
        
    }
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
}

extension ProductosViewController : UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("producto a buscar: \(searchText)")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text!)")
        if let produtToSearch = searchBar.text{
            self.getProducts(product: produtToSearch)
        }
    }
}
