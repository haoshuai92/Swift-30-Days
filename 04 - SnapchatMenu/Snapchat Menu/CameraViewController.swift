//
//  CameraViewController.swift
//  Snapchat Menu
//
//  Created by Shuai Hao on 2019/2/25.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var tempImageView: UIImageView!
    
    var device: AVCaptureDevice! /// 获取设备：如摄像头
    var captureSession : AVCaptureSession! /// 会话，协调着input到output的数据传输，input和output的桥梁
    var previewLayer : AVCaptureVideoPreviewLayer! /// 图像预览层，实时显示捕获的图像
    var output :  AVCaptureVideoDataOutput! /// 图像流输出
    var beganTakePicture:Bool = false /// 相机开始拍照
    
    var photoButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(takePhotoButton)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        captureSession = AVCaptureSession()
        if UIDevice.current.userInterfaceIdiom == .phone {
            captureSession.sessionPreset = AVCaptureSession.Preset.vga640x480
        } else {
            captureSession.sessionPreset = AVCaptureSession.Preset.photo
        }
        // 设置为最高分辨率
        if captureSession.canSetSessionPreset(AVCaptureSession.Preset(rawValue: "AVCaptureSessionPreset1280x720")) {
            captureSession.sessionPreset = AVCaptureSession.Preset(rawValue: "AVCaptureSessionPreset1280x720")
        }
        // 获取输入设备,builtInWideAngleCamera是通用相机,AVMediaType.video代表视频媒体,back表示前置摄像头,如果需要后置摄像头修改为front
        if #available(iOS 10.0, *)
        {
            let availbleDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices
            device = availbleDevices.first
        }
        else
        {
            let devices = AVCaptureDevice.devices(for: .video)
            guard devices.count > 0 else { return } /// 初始化摄像头设备
            guard let device = devices.filter({  return $0.position == .back }).first else { return }
            self.device = device
        }

        // 配置session
        captureSession.beginConfiguration()
        do {
            // 将后置摄像头作为session的input 输入流
            let captureDeviceInput = try AVCaptureDeviceInput(device: device)
            captureSession.addInput(captureDeviceInput)
        } catch {
            print(error.localizedDescription)
        }
        // 设定视频预览层,也就是相机预览layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraView.layer.addSublayer(previewLayer)    /// >>> sessionView 中
        previewLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        previewLayer.videoGravity = .resizeAspectFill  // 相机页面充满拉伸
        // 设定输出流
        output = AVCaptureVideoDataOutput()
        // 指定像素格式
        output.videoSettings = [(kCVPixelBufferPixelFormatTypeKey as NSString):NSNumber(value:kCVPixelFormatType_32BGRA)] as [String : Any]
        // 是否直接丢弃处理旧帧时捕获的新帧,默认为True,如果改为false会大幅提高内存使用
        output.alwaysDiscardsLateVideoFrames = true
        if captureSession.canAddOutput(output) {
            captureSession.addOutput(output)
        }
        captureSession.commitConfiguration()
        captureSession.startRunning()
        // 开新线程进行输出流代理方法调用
        let queue = DispatchQueue(label: "com.brianadvent.captureQueue")
        output.setSampleBufferDelegate(self, queue: queue)

        let captureConnection = output.connection(with: .video)
        if captureConnection?.isVideoStabilizationSupported == true {
            /// 这个很重要 这个是为了拍照完成，防止图片旋转90度
            captureConnection?.videoOrientation = self.getCaptureVideoOrientation()
        }
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if beganTakePicture == true {
            beganTakePicture = false
            /// 注意在主线程中执行
            DispatchQueue.main.async {
                #if false
                self.photoImageView.image = self.imageConvert(sampleBuffer: sampleBuffer)
                self.captureSession.stopRunning()
                self.view.bringSubviewToFront(self.photoView)
                #else
                self.captureSession.stopRunning()
                let image = self.imageConvert(sampleBuffer: sampleBuffer)
                // 导出照片
                let image1 = self.scaleToSize(image: image!, size: CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
                // 放大二倍
                let resultImage = self.imageFromImage(imageFromImage: image1, inRext: CGRect(x: 0, y: 20 + (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * 1)), width: UIScreen.main.bounds.size.width*2, height: (UIScreen.main.bounds.size.width * 1)*2))
                self.tempImageView.image = resultImage
                self.view.bringSubviewToFront(self.cameraView)
                #endif
            }
        }
    }

    func didPressTakePhoto() {

        print("拍照")
    }

    /// 旋转方向
    func getCaptureVideoOrientation() -> AVCaptureVideoOrientation {
        switch UIDevice.current.orientation {
        case .portrait,.faceUp,.faceDown:
            return .portrait
        case .portraitUpsideDown: // 如果这里设置成AVCaptureVideoOrientationPortraitUpsideDown,则视频方向和拍摄时的方向是相反的。
            return .portrait
        case .landscapeLeft:
            return .landscapeRight
        case .landscapeRight:
            return .landscapeLeft
        default:
            return .portrait
        }
    }

    /// CMSampleBufferRef=>UIImage
    func imageConvert(sampleBuffer:CMSampleBuffer?) -> UIImage? {
        guard sampleBuffer != nil && CMSampleBufferIsValid(sampleBuffer!) == true else { return nil }
        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer!)
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer!)
        return UIImage(ciImage: ciImage)
    }

    //1.先实现这个方法后得到返回的照片
    func scaleToSize(image:UIImage!,size:CGSize) -> UIImage{
        // 得到图片上下文，指定绘制范围
        //UIGraphicsBeginImageContext(size);

        /*
         *  UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
         *  CGSize size：指定将来创建出来的bitmap的大小
         *  BOOL opaque：设置透明YES代表透明，NO代表不透明
         *  CGFloat scale：代表缩放,0代表不缩放
         *  创建出来的bitmap就对应一个UIImage对象
         *  为了不影响像素，将图片放大了2倍
         */
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
        // 将图片按照指定大小绘制
        image.draw(in: CGRect(x:0,y:0,width:size.width,height:size.height))
        // 从当前图片上下文中导出图片
        let img:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        // 当前图片上下文出栈
        UIGraphicsEndImageContext();
        // 返回新的改变大小后的图片
        return img
    }
    //2.实现这个方法,,就拿到了截取后的照片.
    func imageFromImage(imageFromImage:UIImage!,inRext:CGRect) ->UIImage{
        //将UIImage转换成CGImageRef
        let sourceImageRef:CGImage = imageFromImage.cgImage!
        // 按照给定的矩形区域进行剪裁
        // CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
        let newImageRef:CGImage = sourceImageRef.cropping(to: inRext)!
        // 将CGImageRef转换成UIImage
        // UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
        let img:UIImage = UIImage.init(cgImage: newImageRef)
        //返回剪裁后的图片
        return img
    }

    // MARK: - 检查相机权限
    func canUseCamera() -> Bool {
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        /*
         notDetermined: // 用户还没有关于这个应用程序做出了选择
         restricted: // 这个应用程序未被授权访问图片数据。用户不能更              改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
         denied: // 用户已经明确否认了这个应用程序访问图片数据
         authorized: // 用户授权此应用程序访问图片数据
         */
        if authStatus == .denied {

            let alert = UIAlertController(title: "请打开相机权限", message: "设置-隐私-相机", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in

            }))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
  
    
    
    
    @IBAction func photoButtonDidTouch(_ sender: UIButton) {
        beganTakePicture = true
    }
    
}
