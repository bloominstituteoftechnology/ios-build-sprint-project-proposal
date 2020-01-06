//
//  ViewController.swift
//  rubato
//
//  Created by Gi Pyo Kim on 12/30/19.
//  Copyright © 2019 GIPGIP Studio. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import MediaPlayer
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    
    var videoPlayer: AVPlayer!
    var playerLayer: AVPlayerLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func chooseVideo(_ sender: Any) {
        presentVideoPickerController()
//        getAuthorizationForAppleMusic()
    }
    
    private func presentVideoPickerController() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            DispatchQueue.main.async {
                let videoPicker = UIImagePickerController()
                videoPicker.sourceType = .photoLibrary
                videoPicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                videoPicker.mediaTypes = [kUTTypeMovie as String]
                videoPicker.allowsEditing = true
                videoPicker.delegate = self
                self.present(videoPicker, animated: true, completion: nil)
            }
        } else {
            // TODO: self.presentInformationalAlertController(title: "Error", message: "The photo library or the camera is unavailable.")
        }
    }
    
    private func presentAudioPickerController() {
        DispatchQueue.main.async {
            let mediaPickerController = MPMediaPickerController(mediaTypes: .any)
            mediaPickerController.delegate = self
            mediaPickerController.prompt = "Select Audio"
            self.present(mediaPickerController, animated: true, completion: nil)
        }
    }
    
    private func getAuthorizationForAppleMusic() {
        let authorizationStatus:MPMediaLibraryAuthorizationStatus = MPMediaLibrary.authorizationStatus()
        
        switch authorizationStatus {
        case MPMediaLibraryAuthorizationStatus.authorized:
            presentAudioPickerController()
            break
        case MPMediaLibraryAuthorizationStatus.notDetermined:
            MPMediaLibrary.requestAuthorization { (authorizationStatus) in
                if authorizationStatus == MPMediaLibraryAuthorizationStatus.authorized {
                    self.presentAudioPickerController()
                } else {
                    print("The Media Library was not authorized by the user")
                }
            }
        default:
            break
        }
    }
    
    private func slowMotion(url: URL) -> AVPlayerItem? {
        let videoAsset = AVURLAsset(url: url)
        
        let comp = AVMutableComposition()
        
        let videoAssetSourceTrack = videoAsset.tracks(withMediaType: AVMediaType.video).first! as AVAssetTrack
        
        let videoCompositionTrack = comp.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        do {
            try videoCompositionTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: CMTimeMakeWithSeconds(10, preferredTimescale: 60)), of: videoAssetSourceTrack, at: CMTime.zero)
            
            let videoScaleFactor = Int64(2.0)
            let videoDuration: CMTime = videoAsset.duration
            
            videoCompositionTrack?.scaleTimeRange(CMTimeRangeMake(start: .zero, duration: videoDuration), toDuration: CMTimeMake(value: videoDuration.value * videoScaleFactor, timescale: videoDuration.timescale))
            videoCompositionTrack?.preferredTransform = videoAssetSourceTrack.preferredTransform
            
            let asset:AVAsset = comp
            print("Slow motion effect completed")
            return AVPlayerItem(asset: asset)
            
        } catch {
            print("Error processing slow motion: \(error)")
            return nil
        }
    }

    
}



extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
            mediaType == (kUTTypeMovie as String),
            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL else {
                
                // TODO: self.presentInformationalAlertController(title: "Error", message: "Please choose a video")
                return
        }
        print("Video URL: \(url)")
                
        videoPlayer = AVPlayer(playerItem: slowMotion(url: url))
        
        playerLayer = AVPlayerLayer(player: videoPlayer)
        var topRect = view.bounds
        topRect.size.height = topRect.height / 1.5
        topRect.size.width = topRect.width / 1.5
        topRect.origin.y = view.safeAreaInsets.top
        playerLayer?.frame = topRect
        view.layer.addSublayer(playerLayer!)
        
        videoPlayer.play()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ViewController: MPMediaPickerControllerDelegate {
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        mediaPicker.dismiss(animated: true) {
            let selectedSongs = mediaItemCollection.items
            guard let song = selectedSongs.first else { return }
            
            let url = song.value(forProperty: MPMediaItemPropertyAssetURL) as? URL
            
            print("Audio URL: \(url)")
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
}

