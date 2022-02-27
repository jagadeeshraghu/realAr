//
//  ExperienceViewController.swift
//  RealityViewer
//
//  Created by Jagadeesh Raghu on 11/7/21.
//

import Foundation
import UIKit
import RealityKit
import ARKit

class ExperienceViewController:UIViewController{
    
    var arView = ARView()
    var r:Int = 2

    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelAction))
        
        
        arView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(arView)
        
        arView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        arView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        arView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true

        if r==2{
            guard let anchor = try? Experience.loadBox() else { return }
            arView.scene.anchors.append(anchor)

        }else{
            guard let anchor = try? Experience2.loadBox() else { return }
            arView.scene.anchors.append(anchor)

        }
        
        
        
        
        

    }


    
    @objc func cancelAction(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
