//
//  ImageSaverToFiles.swift
//  MapApp
//
//  Created by Lewis on 03.06.2022.
//

import UIKit

final class ImageSaverToFiles {
    
    func saveImageToDisk(imageName: String, image: UIImage) {
        let fileManagerDefault = FileManager.default
        
        guard let diskDocumentsDirectory = fileManagerDefault.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileName = imageName
        let fileURL = diskDocumentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        
        deleteImageFromDisk(fileName: fileName)
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("Error saving file, \(error)")
        }
    }
    
    func loadImageFromDisk(fileName: String) -> UIImage? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = paths.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageURL.path)
            return image
        } else {
            return nil
        }
    }
    
    func deleteImageFromDisk(fileName: String) {
        let fileManagerDefault = FileManager.default
        
        guard let diskDocumentsDirectory = fileManagerDefault.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = diskDocumentsDirectory.appendingPathComponent(fileName)

        if fileManagerDefault.fileExists(atPath: fileURL.path) {
            do {
                try fileManagerDefault.removeItem(at: fileURL)
            } catch let error {
                print("Error when removing file on \(fileURL.path), \(error)")
            }
        }
    }
}
