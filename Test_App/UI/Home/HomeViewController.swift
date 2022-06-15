//
//  SampleViewController.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import UIKit

class HomeViewController: UIViewController {
  
  enum SortType {
    case list
    case icon
  }
  
  @IBOutlet var tableView: UITableView!
  
  private var files = [File]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "TableFileViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: "fileTableViewCell")

    Networking.shared.delegate = self
    Networking.shared.fetchFiles()
    
  }
}

extension HomeViewController: NetworkingDelegate {
  func showFiles(with files: [File]) {
    DispatchQueue.main.async {
      self.files = files
      self.tableView.reloadData()
    }
  }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
  private func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! CollectionViewCell
    //
    //                cell.fileLabel(label: labels[indexPath.row])
    //                return cell
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return files.count
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 100, height: 100)
  }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    54
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return files.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "fileTableViewCell", for: indexPath as IndexPath) as! TableFileViewCell
    cell.file = files[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected row with index: \(indexPath.row)")
  }
}


