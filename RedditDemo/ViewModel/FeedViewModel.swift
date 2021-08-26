//
//  FeedViewModel.swift
//  RedditDemo
//
//  Created by dhruva beti on 8/26/21.
//

import Foundation
import UIKit

class FeedViewModel{
    var childrenList:[Children]?
    var title:String?
    var score:String?
    var comments:String?
    var image:UIImage?
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func getTitle(atIndex:Int) -> String?{
        return childrenList?[atIndex].data.title
    }
    
    func getScore(atIndex:Int) -> String?{
        if let score = childrenList?[atIndex].data.score{
            return String("Score:\(score)")
        }
        return String("Score: ")
    }
    
    
    func getComments(atIndex:Int) -> String?{
        if let comments = childrenList?[atIndex].data.num_comments{
            return String("Comments:\(comments)")
        }
        return String("Comments: ")
    }
    
    
    func getImage(atIndex:Int, size:CGSize) -> UIImage?{
        if let  urlString = childrenList?[atIndex].data.preview?.images[0].source.url {
            if let imageForCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
                return imageForCache
            }
            
            if let url = URL(string: urlString.correctUrlString()) {
                if let downsampledLadyImage = downsample(imageAt: url, to: size){
                    imageCache.setObject(downsampledLadyImage, forKey: urlString as AnyObject)
                    return downsampledLadyImage
                }
                
            }
            
        }
        return UIImage(named: "Reddit")
        
    }
    
    func getChildrenList() -> [Children]?{
        return childrenList
    }
    
    func getData(urlString:String, completionHandler:@escaping () -> Void){
        NetworkManager.shared.getData(urlString: urlString) { result in
            self.childrenList = result.data.children
            completionHandler()
        }
    }
    
    func getNextData(urlString:String, completionHandler:@escaping ([Children]) -> Void){
        NetworkManager.shared.getData(urlString: urlString) { result in
            
            let nextChildrenList = result.data.children
            self.childrenList?.append(contentsOf: nextChildrenList)
            completionHandler(nextChildrenList)
        }
    }
    
    
    func downsample(imageAt imageURL: URL,
                    to pointSize: CGSize,
                    scale: CGFloat = UIScreen.main.scale) -> UIImage? {
        
        // Create an CGImageSource that represent an image
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions) else {
            return nil
        }
        
        // Calculate the desired dimension
        let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
        
        // Perform downsampling
        let downsampleOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels
        ] as CFDictionary
        guard let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions) else {
            return nil
        }
        
        // Return the downsampled image as UIImage
        return UIImage(cgImage: downsampledImage)
    }
    
}

extension String{
    
    func correctUrlString() -> String{
        return self.replacingOccurrences(of: "amp;", with: "")
    }
}

