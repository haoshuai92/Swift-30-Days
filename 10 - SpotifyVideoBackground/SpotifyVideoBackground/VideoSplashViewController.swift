//
//  VideoSplashViewController.swift
//  SpotifyVideoBackground
//
//  Created by Shuai Hao on 2019/3/2.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

// 裁切视频
public enum ScalingMode {
    case resize
    case resizeAspect
    case resizeAspectFill
}

class VideoSplashViewController: UIViewController {

    fileprivate let moviePlayer = AVPlayerViewController()
    fileprivate var moviePlayerSoundLevel: Float = 1.0
    
    var contentURL: URL?
    {
        didSet {
            guard let _contenURL = contentURL else {
                return
            }
            setMoviePlayer(_contenURL)
        }
    }
    var videoFrame: CGRect = CGRect()
    var startTime: CGFloat = 0.0
    var duration: CGFloat = 0.0
    var backgroundColor: UIColor = .black {
        didSet {
            view.backgroundColor = backgroundColor
        }
    }
    var sound: Bool = true {
        didSet {
            moviePlayerSoundLevel = (sound ? 1.0 : 0.0)
        }
    }
    
    var alpha: CGFloat = CGFloat() {
        didSet {
            moviePlayer.view.alpha = alpha
        }
    }
    
    var alwaysRepeat: Bool = true {
        didSet {
            if alwaysRepeat {
                NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: moviePlayer.player?.currentItem)
            }
        }
    }
    
    var fillMode: ScalingMode = .resizeAspectFill {
        didSet {
            switch fillMode {
            case .resize:
                moviePlayer.videoGravity = AVLayerVideoGravity.resize
            case .resizeAspect:
                moviePlayer.videoGravity = AVLayerVideoGravity.resizeAspect
            case .resizeAspectFill:
                moviePlayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moviePlayer.view.frame = videoFrame
        moviePlayer.showsPlaybackControls = false
        view.addSubview(moviePlayer.view)
        view.sendSubviewToBack(moviePlayer.view)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func setMoviePlayer(_ url: URL) {
        let videoCutter = VideoCutter()
        videoCutter.cropVideoWithURL(videoUrl: url, startTime: startTime, duration: duration) { (videoPath, error) in
            guard let videoPath = videoPath else {
                return
            }
            DispatchQueue.main.async {
                self.moviePlayer.player = AVPlayer(url: videoPath)
                self.moviePlayer.player?.play()
                self.moviePlayer.player?.volume = self.moviePlayerSoundLevel
            }
            
        }

    }
    

    @objc func playerItemDidReachEnd() {
        moviePlayer.player?.seek(to: CMTime.zero)
        moviePlayer.player?.play()
    }

}
