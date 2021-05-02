//
//  CountryDetailsViewController.swift
//  galileoTest
//
//  Created by Mark Abrasaldo on 5/2/21.
//

import UIKit
import SDWebImage
import SDWebImageSVGCoder

class CountryDetailsViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var countryCapitalLabel: UILabel!
    @IBOutlet weak var countryAlpha2CodeLabel: UILabel!
    @IBOutlet weak var countryAlpha3CodeLabel: UILabel!
    @IBOutlet weak var countryPopulationLabel: UILabel!
    
    var countryFlag: String?
    var countryName: String?
    var countryCapital: String?
    var countryAlpha2Code: String?
    var countryAlpha3Code: String?
    var countryPopulation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let countryName = countryName {
            title = "\(countryName) Details"
        }
        
        let svg = URL(string: countryFlag!)!
        let bitmapSize = CGSize(width: 274, height: 147)
        flagImageView.sd_setImage(with: svg, placeholderImage: nil, options: [], context: [.imageThumbnailPixelSize : bitmapSize])
//        flagImageView.sd_setImage(with: svg)
        countryNameLabel.text = countryName
        countryCapitalLabel.text = countryCapital
        countryAlpha2CodeLabel.text = countryAlpha2Code
        countryAlpha3CodeLabel.text = countryAlpha3Code
        countryPopulationLabel.text = countryPopulation
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
