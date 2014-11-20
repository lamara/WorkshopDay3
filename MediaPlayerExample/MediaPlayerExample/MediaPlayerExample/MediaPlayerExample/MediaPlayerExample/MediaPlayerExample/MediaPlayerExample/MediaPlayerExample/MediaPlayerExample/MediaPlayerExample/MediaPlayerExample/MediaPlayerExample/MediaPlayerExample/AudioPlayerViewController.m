//
//  AudioPlayerViewController.m
//  MediaPlayerExample
//
//  Created by Alex Lamar on 11/9/14.
//  Copyright (c) 2014 Alex Lamar. All rights reserved.
//

#import "AudioPlayerViewController.h"

@implementation AudioPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
}

- (void)initializeView
{
    if (self.currentSong == nil) {
        //No song selected, gray out this menu
        self.nameLabel.text = @"No song selected";
        self.albumLabel.text = @"";
        self.artistLabel.text = @"";
        
        //Set the buttons to disabled, will automatically gray out the buttons
        [self.playButton setEnabled:NO];
        [self.pauseButton setEnabled:NO];
    }
    else {
        self.nameLabel.text = [self.currentSong songName];
        self.albumLabel.text = [self.currentSong albumName];
        self.artistLabel.text = [self.currentSong artist];
        
        //Set the buttons to enabled incase they were previously disabled
        [self.playButton setEnabled:YES];
        [self.playButton setEnabled:YES];
    }
}

- (IBAction)play:(id)sender {
    [self.currentSong.audioPlayer play];
}


- (IBAction)pause:(id)sender {
    [self.currentSong.audioPlayer pause];
}

- (void)transitionToTrack:(ALXSong*)track
{
    self.currentSong = track;
    [self initializeView];
}

@end
