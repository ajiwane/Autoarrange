//
//  ViewController.h
//  Testing
//
//  Created by Ashwin Jiwane on 8/19/12.
//  Copyright (c) 2012 Ashwin Jiwane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate>
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;

@end
