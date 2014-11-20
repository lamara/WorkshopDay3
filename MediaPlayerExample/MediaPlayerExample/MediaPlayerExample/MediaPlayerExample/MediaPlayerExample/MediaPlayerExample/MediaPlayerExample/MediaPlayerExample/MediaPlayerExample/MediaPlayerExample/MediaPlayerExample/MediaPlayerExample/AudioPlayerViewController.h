//
//  AudioPlayerViewController.h
//  MediaPlayerExample
//
//  Created by Alex Lamar on 11/9/14.
//  Copyright (c) 2014 Alex Lamar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ALXSong.h"


@interface AudioPlayerViewController : UIViewController

@property ALXSong *currentSong;
@property NSArray *playlist;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;

@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

-(void)play;

-(void)pause;

- (void)transitionToTrack:(ALXSong*)track;


@end
