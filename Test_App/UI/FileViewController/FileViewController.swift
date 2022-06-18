//
//  FileViewController.swift
//  Test_App
//
//  Created by Georgie Muler on 14.06.2022.
//

import UIKit

protocol FileNavigation {
    func showFolder(with file: File, viewType: FileViewController.ViewType)
}

class FileViewController: UIViewController, StoryboardInitializable {
    
    enum ViewType {
        case list
        case icon
    }
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    var coordinator: FileNavigation?
    private var currentViewType: ViewType = .list
    private var isNeedToToggleViewType = false
    private var currentPath = ""
    private var files = [File]()
    private var filesInCurrentPath: [File] {
        get {
            elementsInCurrentPath()
        }
    }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedToToggleViewType {
            toggleViewType()
        }
    }
    
    func configure(with coordinator: FileNavigation,
                   currentPath: String = "",
                   isNeedToToggleViewType: Bool = false) {
        self.coordinator = coordinator
        self.currentPath = currentPath
        self.isNeedToToggleViewType = isNeedToToggleViewType
    }
    
    private func elementsInCurrentPath() -> [File] {
        var filesInCurrentPath = [File]()
        for file in files {
            if file.parentId == currentPath {
                filesInCurrentPath.append(file)
            }
        }
        return filesInCurrentPath
    }
    
    private func toggleViewType() {
        if case .list = currentViewType {
            collectionView.isHidden = false
            tableView.isHidden = true
            currentViewType = .icon
        } else if case .icon = currentViewType {
            collectionView.isHidden = true
            tableView.isHidden = false
            currentViewType = .list
        }
    }
    
    @IBAction func addFilePressed(_ sender: UIBarButtonItem) {
        print("1")
    }
    @IBAction func addFolderPressed(_ sender: UIBarButtonItem) {
        print("2")
    }
    
    @IBAction func sortTypeButton(_ sender: UIBarButtonItem) {
        print("3")
        toggleViewType()
    }
}

extension FileViewController: NetworkingDelegate {
    func showFiles(with files: [File]) {
        DispatchQueue.main.async {
            self.files = files
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FileViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fileCollectionViewCell", for: indexPath as IndexPath) as! CollectionFileViewCell
        cell.file = filesInCurrentPath[indexPath.row]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return filesInCurrentPath.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFile = filesInCurrentPath[indexPath.row]
        if currentFile.type == .directory {
            coordinator?.showFolder(with: currentFile, viewType: currentViewType)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width / 4.0
        let yourHeight = yourWidth + 20
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension FileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesInCurrentPath.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fileTableViewCell", for: indexPath as IndexPath) as! TableFileViewCell
        cell.file = filesInCurrentPath[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentFile = filesInCurrentPath[indexPath.row]
        if currentFile.type == .directory {
            coordinator?.showFolder(with: currentFile, viewType: currentViewType)
        }
    }
}
