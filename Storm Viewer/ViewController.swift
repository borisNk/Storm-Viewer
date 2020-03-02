//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Boris Nikolaev Borisov on 12/02/2020.
//  Copyright © 2020 Boris Nikolaev Borisov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let chevron = UIImage(named: "chevron.png")
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recomendAppTapped))
        
        performSelector(inBackground: #selector(getPictures), with: nil)
    }
    
    @objc func getPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort(by: { $0 < $1})
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
    
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView = UIImageView(image: chevron!)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedIndex = indexPath.row + 1
            vc.totalSize = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func recomendAppTapped() {
        let message = "You should try this app!"
        let vc = UIActivityViewController(activityItems: [message], applicationActivities: [])
               vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
               present(vc, animated: true)
    }
}

