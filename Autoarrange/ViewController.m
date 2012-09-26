//
//  ViewController.m
//  Testing
//
//  Created by Ashwin Jiwane on 8/19/12.
//  Copyright (c) 2012 Ashwin Jiwane. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize assetsLibrary = _assetsLibrary;

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"In View Did Appear");
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index,BOOL *stop) {
                __block BOOL foundThePhoto = NO;
                if (foundThePhoto) {
                    *stop = YES;
                }
                NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                if ([assetType isEqualToString:ALAssetTypePhoto]){
                    
                    NSLog(@"This is a photo asset");
                    foundThePhoto = YES;
                    *stop = YES;
                    /* Get the asset's representation object */
                    ALAssetRepresentation *assetRepresentation = [result defaultRepresentation];
                    
                    dispatch_async(dispatch_get_main_queue(), ^(void) {
                        
                        CGImageRef imageReference = [assetRepresentation fullResolutionImage];
                        /* Construct the image now */
                        UIImage *image =
                        [[UIImage alloc] initWithCGImage:imageReference];
                        
                        if (image != nil){
                            NSLog(@"got image");
                        } else {
                            NSLog(@"Failed to create the image.");
                        }
                    });
                }
            }];
        } failureBlock:^(NSError *error) {
            NSLog(@"Failed to enumerate the asset groups.");
        }];
    });
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
