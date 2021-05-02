//
//  CountriesTableViewController.swift
//  galileoTest
//
//  Created by Mark Abrasaldo on 5/1/21.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class CountryTableViewCell: UITableViewCell {
    @IBOutlet weak var CountryImageView: UIImageView!
    @IBOutlet weak var CountryLabel: UILabel!
}

class CountriesTableViewController: UITableViewController {
    
    @IBOutlet weak var countrySearchBar: UISearchBar!
    
    var countries = [Country]()
    
    var filteredCountries: [Country]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        filteredCountries?.removeAll()
        countries.removeAll()
        filteredCountries = countries
        
        countrySearchBar.delegate = self
        
        getCountry()
        { (isDone) in
            
            if isDone {
                self.filteredCountries = self.countries
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
    }
    
    func getCountry(completion: @escaping(Bool)->Void) {
        
        
        
        CountryService.init().getCountry() { (successGetRESTCountryResponseModel, error) in
            
            if successGetRESTCountryResponseModel != nil {
                
                if let successGetRESTCountryResponseModel = successGetRESTCountryResponseModel {
                    
                    for country in successGetRESTCountryResponseModel {
                        
                        let countryModel = Country.init(alpha2Code: country.alpha2Code,
                                                        alpha3Code: country.alpha3Code,
                                                        capital: country.capital,
                                                        image: country.flag,
                                                        name: country.name,
                                                        population: String(country.population!))
                        self.countries.append(countryModel)
                    }
                }
                
                completion(true)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredCountries!.count

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell")! as! CountryTableViewCell
        
        let country = filteredCountries![indexPath.row]
        cell.CountryLabel.text = country.name
        let svg = URL(string: country.image!)!
        let bitmapSize = CGSize(width: 35, height: 35)
        cell.CountryImageView.sd_setImage(with: svg, placeholderImage: nil, options: [], context: [.imageThumbnailPixelSize : bitmapSize])
        return cell
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "countryDetails") as! CountryDetailsViewController
        vc.countryAlpha2Code = filteredCountries![indexPath.row].alpha2Code
        vc.countryAlpha3Code = filteredCountries![indexPath.row].alpha3Code
        vc.countryFlag = filteredCountries![indexPath.row].image
        vc.countryCapital = filteredCountries![indexPath.row].capital
        vc.countryName = filteredCountries![indexPath.row].name
        vc.countryPopulation = filteredCountries![indexPath.row].population
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CountriesTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCountries = []
        
        if searchText == "" {
            filteredCountries = countries
        }
        else {
            for country in countries {
                
                if country.name!.lowercased().contains(searchText.lowercased()) ||
                    country.alpha2Code!.lowercased().contains(searchText.lowercased()) ||
                    country.alpha3Code!.lowercased().contains(searchText.lowercased()) {
                    
                    filteredCountries!.append(Country(alpha2Code: country.alpha2Code,
                                                      alpha3Code: country.alpha3Code,
                                                      image: country.image,
                                                      name: country.name))
                }
            }
        }
        
        self.tableView.reloadData()
    }
}
