//
//  HomeViewController.swift
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
    
    var currentState: SortType = .icon
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    private var files = [File]()
    private let itemsPerRow: CGFloat = 3
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableFileViewCell",
                                 bundle: nil),
                           forCellReuseIdentifier: "fileTableViewCell")
        
        Networking.shared.delegate = self
        Networking.shared.fetchFiles()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionFileViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "fileCollectionViewCell")
    }
    @IBAction func addFilePressed(_ sender: UIBarButtonItem) {
        print("1")
    }
    @IBAction func addFolderPressed(_ sender: UIBarButtonItem) {
        print("2")
    }
    
    @IBAction func sortTypeButton(_ sender: UIBarButtonItem) {
        print("3")
        if case .list = currentState {
            collectionView.isHidden = false
            tableView.isHidden = true
            currentState = .icon
        } else if case .icon = currentState {
            collectionView.isHidden = true
            tableView.isHidden = false
            currentState = .list
        }
    }
    
}

extension HomeViewController: NetworkingDelegate {
    func showFiles(with files: [File]) {
        DispatchQueue.main.async {
            self.files = files
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fileCollectionViewCell", for: indexPath as IndexPath) as! CollectionFileViewCell
        cell.file = files[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return files.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 4.0
        let yourHeight = yourWidth + 20
        
        return CGSize(width: yourWidth, height: yourHeight)
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



