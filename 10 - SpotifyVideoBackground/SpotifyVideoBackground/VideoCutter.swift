//
//  VideoCutter.swift
//  SpotifyVideoBackground
//
//  Created by Shuai Hao on 2019/3/2.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit
import AVFoundation

extension String {
    var convert: NSString{return (self as NSString)}
}

class VideoCutter: NSObject {

    func cropVideoWithURL(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion:((_ videoPath: URL?, _ error: Error?) -> Void)?) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            let asset = AVURLAsset(url: url)
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = paths.object(at: 0) as! String
            let manager = FileManager.default
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            } catch _ {
            }
            
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            do {
                try manager.removeItem(atPath: outputURL)
            } catch _ {
            }
            
            if let exportSession = exportSession as AVAssetExportSession? {
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileType.mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), preferredTimescale: 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: 600)
                let range = CMTimeRange(start: start, duration: duration)
                exportSession.timeRange = range
                
                exportSession.exportAsynchronously {
                    switch exportSession.status {
                    case .completed:
                        completion?(exportSession.outputURL, nil)
                    case .failed:
                        print("Failed: \(String(describing: exportSession.error))")
                    case .cancelled:
                        print("Cancelled: \(String(describing: exportSession.error))")
                    default:
                        print("default case")
                    }
                    
                }
            }
            
        }
    
    }
}
