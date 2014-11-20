//
//  ALXSongListViewController.m
//  MediaPlayerExample
//
//  Created by Alex Lamar on 11/9/14.
//  Copyright (c) 2014 Alex Lamar. All rights reserved.
//

#import "ALXSongListViewController.h"
#import "AudioPlayerViewController.h"

@implementation ALXSongListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.songList = [[NSMutableArray alloc] init];
    
    [self loadInitialData];
}

-(void)loadInitialData
{
    //Create the first song
    NSURL *url1 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Kamei - Falling in Love" ofType:@"mp3"]];
    ALXSong *song1 = [[ALXSong alloc] initWithUrl:url1 andObserver:self andCallbackMethod:@selector(trackDidFinish:)];
    [self.songList addObject:song1];
    //NSLog(@"%f", CMTimeGetSeconds(song1.playerItem.asset.duration));
    
    
    //Create the second song
    NSURL *url2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Hugo Kant - Hittin' The Bottle" ofType:@"mp3"]];
    ALXSong *song2 = [[ALXSong alloc] initWithUrl:url2 andObserver:self andCallbackMethod:@selector(trackDidFinish:)];
    [self.songList addObject:song2];
     //NSLog(@"%f", CMTimeGetSeconds(song2.playerItem.asset.duration));
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.songList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *items = self.songList;
    
    // Return a cell to be used for the row at the given index
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
    
    ALXSong *currentSong = [items objectAtIndex:indexPath.row];
    
    //Set the cell's main text/detail text to the song's information
    cell.detailTextLabel.text = [currentSong songName];
    cell.textLabel.text = [currentSong artist];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ALXSong *selectedSong = [self.songList objectAtIndex:indexPath.row];
    
    
    //Set the current song if it does not already exist
    if (self.currentSong == nil) {
        self.currentSong = selectedSong;
        //[self.currentSong.audioPlayer seekToTime:CMTimeMake(280, 1)];
        [self.currentSong.audioPlayer play];
        return;
    }
    
    //If we are looking at a different item, then set the current item to it.
    if (self.currentSong == selectedSong) {
        //We've selected an already-playing item
        if (self.currentSong.audioPlayer.rate == 0) {
            //The song is paused, so lets start it up again
            [self.currentSong.audioPlayer play];
        }
        else {
            //The song is already playing, so we don't need to do anything
        }
    }
    else {
        //We've selected a new track from the list
        [self resetCurrentTrack];
        
        self.currentSong = selectedSong;
        
        [self.currentSong.audioPlayer play];
    }
}

-(void)trackDidFinish:(NSNotification *) notification
{
    NSLog(@"Track finished");
    
    NSUInteger currentIndex = [self.songList indexOfObject:self.currentSong];
    //If there are still songs left in the playlist, then we'll advance forward
    if (currentIndex + 1 < [self.songList count]) {
        //First, let's explicitly reset the current song
        [self resetCurrentTrack];
        
        //Find the new song in the playlist, and set our current pointer to it.
        ALXSong *newSong = [self.songList objectAtIndex:currentIndex + 1];
        self.currentSong = newSong;
        
        //Play the song.
        [self.currentSong.audioPlayer play];
        
        //Select the song's row in the tableview so the UI gets updated, as well.
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:(currentIndex + 1) inSection:0];
        [self.tableView selectRowAtIndexPath:newIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
        //Update the view of the audio player, if it exists (i.e. if it's the current screen of the app)
        if (self.playerController != nil)
        {
            [self.playerController transitionToTrack:self.currentSong];
        }
        
        
    }
}

-(void)resetCurrentTrack
{
    if (self.currentSong == nil) {
        return;
    }
    //Create a CMTime at 0 seconds
    CMTime beginning = CMTimeMake(0, 1);
    
    //Pause the track and seek it back to the beginning
    [self.currentSong.audioPlayer pause];
    [self.currentSong.audioPlayer seekToTime:beginning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    AudioPlayerViewController *controller = [[segue destinationViewController] visibleViewController];
    controller.playlist = self.songList;
    controller.currentSong = self.currentSong;
    
    self.playerController = controller;
}

@end