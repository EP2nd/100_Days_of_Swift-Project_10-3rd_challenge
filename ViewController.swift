//
//  ViewController.swift
//  Project1
//
//  Created by Edwin Przeźwiecki Jr. on 18/11/2021.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(recommendApp))
        
        /* let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
         
        print(pictures.sort()) */
        
        performSelector(inBackground: #selector(loadImages), with: nil)
        
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell.")
        }
        
        //cell.name.text = pictures[indexPath.row]
        
        cell.name.text = pictures[indexPath.row]
        cell.view.image = UIImage(named: pictures[indexPath.row])
        cell.view.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.view.layer.borderWidth = 2
        cell.view.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedImage = pictures[indexPath.row]
            detailVC.selectedPictureNumber = indexPath.row + 1
            detailVC.totalPictures = pictures.count

            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func loadImages() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    @objc func recommendApp() {
        
        let recommend = "Check out my first app!"
        
        let vc = UIActivityViewController(activityItems: [recommend], applicationActivities: [])
        
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(vc, animated: true)
    }
}
