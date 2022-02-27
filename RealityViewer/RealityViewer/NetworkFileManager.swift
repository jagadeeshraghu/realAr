//
//  NetworkFileManager.swift
//  RealityViewer
//
//  Created by Jagadeesh Raghu on 11/6/21.
//

import Foundation

protocol NetworkManagerDelegate:NSObject{
    func downloadedFileLocalURL(url:URL)
}

class NetworkManager:NSObject{
    
    weak var delegate:NetworkManagerDelegate?
    
    func downloadUrl(url:URL){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                //  in case of failure to download your data you need to present alert to the user
                print(error ?? "Data Error")
                return
            }
            // you neeed to check if the downloaded data is a valid pdf
            guard
                let httpURLResponse = response as? HTTPURLResponse
            else {
                print((response as? HTTPURLResponse)?.mimeType ?? "")
                return
            }
            do {
                // rename the temporary file or save it to the document or library directory if you want to keep the file
                let suggestedFilename = httpURLResponse.suggestedFilename ?? "quicklook.usdz"
                let previewURL = FileManager.default.temporaryDirectory.appendingPathComponent(suggestedFilename)
                try data.write(to: previewURL, options: .atomic)  
                
                self.delegate?.downloadedFileLocalURL(url: previewURL)
            } catch {
                print(error)
                return
            }
        }.resume()
        
        
    }
    
    
}
