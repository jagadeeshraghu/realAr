//
//  ViewController.swift
//  RealityViewer
//
//  Created by Jagadeesh Raghu on 11/6/21.
//

import UIKit
import QuickLook
import RealityKit
import QuickLook
import UIKit
import Photos
import PhotosUI


class ViewController: UIViewController, QLPreviewControllerDelegate, QLPreviewControllerDataSource,NetworkManagerDelegate,UITableViewDelegate,UITableViewDataSource, UINavigationBarDelegate, PHPickerViewControllerDelegate{
        

    
    lazy var actionsTableView:UITableView = {
        
        let tableView  = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints  = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "actionCell")
        
        return tableView
        
        
    }()
    
    var previewItems: [PreviewItem] = []
    
    lazy var previewController:QLPreviewController = {
        let previewController = QLPreviewController()
        previewController.delegate = self
        previewController.dataSource = self
        previewController.view.backgroundColor = UIColor.white
        
        return previewController
    }()
       
    
    lazy var downloadingView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var downloadLabel:UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Downloading..."
        
        return view
    }()
    

    
    lazy var loadingIndicator:UIActivityIndicatorView = {
        
        let loadingIndictor  = UIActivityIndicatorView()
        loadingIndictor.translatesAutoresizingMaskIntoConstraints = false
        
        return loadingIndictor
        
    }()
    
    lazy var networkManager:NetworkManager = {
        
        let networkManager  = NetworkManager()
        networkManager.delegate = self
        
        return networkManager
        
    }()
    
    var navbar = UINavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navbar.delegate = self
        navbar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(actionsTableView)

        let navItem = UINavigationItem()
        navItem.title = "Augmented Reality"
        navbar.items = [navItem]

        view.addSubview(navbar)
        navbar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        navbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        navbar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        navbar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        
        actionsTableView.topAnchor.constraint(equalTo: self.navbar.bottomAnchor).isActive = true
        actionsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        actionsTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        actionsTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true


    }
    
    

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        previewItems.count
    }
    
    func showDownloadingView(){
        self.view.addSubview(downloadingView)
        self.downloadingView.addSubview(loadingIndicator)
        self.downloadingView.addSubview(downloadLabel)
        
        downloadingView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        downloadingView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        downloadingView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        downloadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        downloadLabel.centerXAnchor.constraint(equalTo: self.downloadingView.centerXAnchor).isActive = true
        downloadLabel.centerYAnchor.constraint(greaterThanOrEqualToSystemSpacingBelow: self.downloadingView.centerYAnchor, multiplier: 0.2).isActive = true
        downloadLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        downloadLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true


        
        loadingIndicator.startAnimating()
        loadingIndicator.centerXAnchor.constraint(equalTo: downloadingView.centerXAnchor, constant: 50).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: self.downloadingView.centerYAnchor).isActive = true
        

    }
    
    func quickLook(url: URL) {
        self.downloadLabel.text = "Downloading..."
        showDownloadingView()
        networkManager.downloadUrl(url: url)
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        
        previewItems[index]
        
    }
    
    func downloadedFileLocalURL(url: URL) {
        
        var previewURL = url
        previewURL.hasHiddenExtension = true
        let previewItem = PreviewItem()
        previewItem.previewItemURL = previewURL
        self.previewItems.append(previewItem)
        DispatchQueue.main.async {
            self.previewController.delegate = self
            self.previewController.dataSource = self
            self.previewController.currentPreviewItemIndex = 0
            self.loadingIndicator.stopAnimating()
            self.loadingIndicator.removeFromSuperview()
            self.downloadingView.removeFromSuperview()
            self.present(self.previewController, animated: true)
         }

        
    }
    
    //Mark: TableViewDelegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:UITableViewCell = UITableViewCell.init(style: .default, reuseIdentifier: "actionCell")
        
        if indexPath.row == 0{
            cell.textLabel?.text = "Upload Photos"
            cell.detailTextLabel?.text = "Open's Camera View to Scan's Object"
        }else if indexPath.row == 1{
            cell.textLabel?.text = "Display Object from cloud"
            cell.detailTextLabel?.text = "Display scanned Oject"
        }
        else if indexPath.row == 2{
            cell.textLabel?.text = "Experience 1"
            cell.detailTextLabel?.text = "Display scanned Oject"
        }
        else if indexPath.row == 3{
            cell.textLabel?.text = "Experience 2"
            cell.detailTextLabel?.text = "Display scanned Oject"
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            showCamera()
            
        }else if indexPath.row == 1{
            
            let url = URL(string:"https://storage.googleapis.com/analog-hull-331319.appspot.com/carmodel.usdz")!
            quickLook(url: url)
            
        }else if indexPath.row == 2{
            showReality(r: indexPath.row)
        }
        else if indexPath.row == 3{
            showReality(r: indexPath.row)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    var imagePicker: PHPickerViewController!
    
    func showCamera()
    {
        
        var photoConfiguration = PHPickerConfiguration.init()
        photoConfiguration.filter = .images
        photoConfiguration.selectionLimit = 100
        imagePicker =  PHPickerViewController.init(configuration: photoConfiguration)
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)

    }
    
    
    func showReality(r:Int)
    {
        
        let viewController = ExperienceViewController()

        viewController.r = r
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        
        
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
//        let boxAnchor = try! MyScene.loadBox()
//
//        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)


    }

    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true, completion: nil)
        self.downloadLabel.text = "Uploading..."
        self.showDownloadingView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            
            self.downloadingView.removeFromSuperview()
        }
        
        
        for result in results {
            
        }
        
    }

}

class PreviewItem: NSObject, QLPreviewItem {
    var previewItemURL: URL?
}

extension URL {
    var hasHiddenExtension: Bool {
        get { (try? resourceValues(forKeys: [.hasHiddenExtensionKey]))?.hasHiddenExtension == true }
        set {
            var resourceValues = URLResourceValues()
            resourceValues.hasHiddenExtension = newValue
            try? setResourceValues(resourceValues)
        }
    }
}
