//
//  DILArtistMusicViewCell.m
//  Dillo Day
//
//  Created by Phil Meyers IV on 4/4/15.
//  Copyright (c) 2015 Mayfest. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DILArtistMusicViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <PureLayout/PureLayout.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ParseUI.h"

@interface DILExternalStreamingServiceButton : UIButton
@property (strong, nonatomic) NSURL *externalURL;
@end

@implementation DILExternalStreamingServiceButton
@end

@interface DILArtistMusicViewCell()
@property (strong, nonatomic) NSMutableArray *externalStreamingButtonArray;
@property (strong, nonatomic) DILExternalStreamingServiceButton *spotifyLinkButton;
@property (strong, nonatomic) DILExternalStreamingServiceButton *appleMusicLinkButton;
@property (strong, nonatomic) DILExternalStreamingServiceButton *soundCloudLinkButton;
@property (strong, nonatomic) DILExternalStreamingServiceButton *youtubeLinkButton;
@property (strong, nonatomic) DILExternalStreamingServiceButton *bandcampLinkButton;
@end

@implementation DILArtistMusicViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    CGFloat iconSideLength = self.contentView.frame.size.width / 4;
    CGFloat horizontalInset = self.contentView.frame.size.width / 16;
    CGFloat verticalInset = 15.0;
    CGFloat secondRowHorizontalInset = iconSideLength / 2 + horizontalInset;
    
    CGSize iconSize = CGSizeMake(iconSideLength, iconSideLength);
    
    [self.contentView addSubview:self.spotifyLinkButton];
    [_spotifyLinkButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:verticalInset];
    [_spotifyLinkButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:horizontalInset];
    [_spotifyLinkButton autoSetDimensionsToSize:iconSize];

    [self.contentView addSubview:self.appleMusicLinkButton];
    [_appleMusicLinkButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:verticalInset];
    [_appleMusicLinkButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_appleMusicLinkButton autoSetDimensionsToSize:iconSize];

    [self.contentView addSubview:self.youtubeLinkButton];
    [_youtubeLinkButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:verticalInset];
    [_youtubeLinkButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:horizontalInset];
    [_youtubeLinkButton autoSetDimensionsToSize:iconSize];

    
    [self.contentView addSubview:self.soundCloudLinkButton];
    [_soundCloudLinkButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:secondRowHorizontalInset];
    [_soundCloudLinkButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_spotifyLinkButton withOffset:verticalInset];
    [_soundCloudLinkButton autoSetDimensionsToSize:iconSize];

    [self.contentView addSubview:self.bandcampLinkButton];
    [_bandcampLinkButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:secondRowHorizontalInset];
    [_bandcampLinkButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_youtubeLinkButton withOffset:verticalInset];
    [_bandcampLinkButton autoSetDimensionsToSize:iconSize];
}

- (DILExternalStreamingServiceButton *)spotifyLinkButton {
    if (!_spotifyLinkButton) {
        _spotifyLinkButton = [[DILExternalStreamingServiceButton alloc] initForAutoLayout];
        [self.spotifyLinkButton addTarget:self action:@selector(openExternalStreamingPlaybackService:) forControlEvents:UIControlEventTouchUpInside];
    }
    _spotifyLinkButton.userInteractionEnabled = YES;
    return _spotifyLinkButton;
}

- (DILExternalStreamingServiceButton *)appleMusicLinkButton {
    if (!_appleMusicLinkButton) {
        _appleMusicLinkButton = [[DILExternalStreamingServiceButton alloc] initForAutoLayout];
        [self.appleMusicLinkButton addTarget:self action:@selector(openExternalStreamingPlaybackService:) forControlEvents:UIControlEventTouchUpInside];
    }
    _appleMusicLinkButton.userInteractionEnabled = YES;
    return _appleMusicLinkButton;
}

- (DILExternalStreamingServiceButton *)soundCloudLinkButton {
    if (!_soundCloudLinkButton) {
        _soundCloudLinkButton = [[DILExternalStreamingServiceButton alloc] initForAutoLayout];
        [self.soundCloudLinkButton addTarget:self action:@selector(openExternalStreamingPlaybackService:) forControlEvents:UIControlEventTouchUpInside];
    }
    _soundCloudLinkButton.userInteractionEnabled = YES;
    return _soundCloudLinkButton;
}

- (DILExternalStreamingServiceButton *)youtubeLinkButton {
    if (!_youtubeLinkButton) {
        _youtubeLinkButton = [[DILExternalStreamingServiceButton alloc] initForAutoLayout];
        [self.youtubeLinkButton addTarget:self action:@selector(openExternalStreamingPlaybackService:) forControlEvents:UIControlEventTouchUpInside];
    }
    _youtubeLinkButton.userInteractionEnabled = YES;
    return _youtubeLinkButton;
}

- (DILExternalStreamingServiceButton *)bandcampLinkButton {
    if(!_bandcampLinkButton) {
        _bandcampLinkButton = [[DILExternalStreamingServiceButton alloc] initForAutoLayout];
        [self.bandcampLinkButton addTarget:self action:@selector(openExternalStreamingPlaybackService:) forControlEvents:UIControlEventTouchUpInside];
    }
    _bandcampLinkButton.userInteractionEnabled = YES;
    return _bandcampLinkButton;
}

- (void)configureCellWithArtist:(DILPFArtist *)artist{
    if (artist.spotifyUrl) {
        NSURL *spotifyAppURL = [NSURL URLWithString:[@"spotify://artist/" stringByAppendingString:artist.spotifyUrl]];
        NSURL *spotifyBackupURL = [NSURL URLWithString:[@"http://open.spotify.com/artist/" stringByAppendingString:artist.spotifyUrl]];
        self.spotifyLinkButton.externalURL = [UIApplication.sharedApplication canOpenURL:spotifyAppURL] ? spotifyAppURL : spotifyBackupURL;
        [_spotifyLinkButton setBackgroundImage:[UIImage imageNamed:@"SpotifyIcon"] forState:UIControlStateNormal];
    } else {
        [_spotifyLinkButton setBackgroundImage:[UIImage imageNamed:@"SpotifyIconBW"] forState:UIControlStateNormal];
    }
    
    if (artist.aplUrl) {
        self.appleMusicLinkButton.externalURL = [NSURL URLWithString:[@"https://itun.es/us/" stringByAppendingString:artist.aplUrl]];
        [_appleMusicLinkButton setBackgroundImage:[UIImage imageNamed:@"AppleMusicIcon"] forState:UIControlStateNormal];
    } else {
        [_appleMusicLinkButton setBackgroundImage:[UIImage imageNamed:@"AppleMusicIconBW"] forState:UIControlStateNormal];
    }
    
    if (artist.soundcloudUrl) {
        NSURL *soundCloudAppURL = [NSURL URLWithString:[@"soundcloud:users:" stringByAppendingString:artist.soundcloudUrl]];
        NSURL *soundCloudBackupURL = [NSURL URLWithString:[@"https://soundcloud.com/" stringByAppendingString:artist.soundcloudUsername]];
        self.soundCloudLinkButton.externalURL = [UIApplication.sharedApplication canOpenURL:soundCloudAppURL] ? soundCloudAppURL : soundCloudBackupURL;
        [_soundCloudLinkButton setBackgroundImage:[UIImage imageNamed:@"SoundCloudIcon"] forState:UIControlStateNormal];
    } else {
        [_soundCloudLinkButton setBackgroundImage:[UIImage imageNamed:@"SoundCloudIconBW"] forState:UIControlStateNormal];
    }
    
    if (artist.youtubeUrl) {
        self.youtubeLinkButton.externalURL = [NSURL URLWithString:[@"https://www.youtube.com/user/" stringByAppendingString:artist.youtubeUrl]];
        [_youtubeLinkButton setBackgroundImage:[UIImage imageNamed:@"YoutubeIcon"] forState:UIControlStateNormal];
    } else {
        [_youtubeLinkButton setBackgroundImage:[UIImage imageNamed:@"YoutubeIconBW"] forState:UIControlStateNormal];
    }
    
    if (artist.bandcampURL) {
        self.bandcampLinkButton.externalURL = [NSURL URLWithString:[[@"https://" stringByAppendingString:artist.bandcampURL] stringByAppendingString: @".bandcamp.com"]];
        [_bandcampLinkButton setBackgroundImage:[UIImage imageNamed:@"BandcampIcon"] forState:UIControlStateNormal];
    } else {
        [_bandcampLinkButton setBackgroundImage:[UIImage imageNamed:@"BandcampIconBW"] forState:UIControlStateNormal];
    }
}
                                                              
- (void)openExternalStreamingPlaybackService:(id)sender {
    DILExternalStreamingServiceButton *currentButton = (DILExternalStreamingServiceButton *)sender;
    if (currentButton.externalURL) {
        [UIApplication.sharedApplication openURL:currentButton.externalURL];
    } else {
        [SVProgressHUD showInfoWithStatus:@"Artist hasn't shared their music here yet"];
    }
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
