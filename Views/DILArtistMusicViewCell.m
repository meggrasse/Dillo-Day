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
#import "ParseUI.h"

@interface DILArtistMusicViewCell()
@property (strong, nonatomic) UIButton *spotifyBtn;
@property (strong, nonatomic) UIButton *tidalBtn;
@property (strong, nonatomic) UIButton *aplBtn;
@property (strong, nonatomic) UIButton *soundcloudBtn;
@property (strong, nonatomic) UIButton *youtubeBtn;
@property (strong, nonatomic) NSString *spotifyUrl;
@property (strong, nonatomic) NSString *tidalUrl;
@property (strong, nonatomic) NSString *aplUrl;
@property (strong, nonatomic) NSString *soundcloudUrl;
@property (strong, nonatomic) NSString *youtubeUrl;
@property (strong, nonatomic) UIView *btnView;
//google play
@end

@implementation DILArtistMusicViewCell
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureCell];
    }
    return self;
}

- (void)configureCell {
    CGFloat icon_dim = self.contentView.frame.size.width/4;
    
    [self.contentView addSubview:self.spotifyBtn];
    [_spotifyBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [_spotifyBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15.0];
    [_spotifyBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];

    [self.contentView addSubview:self.aplBtn];
    [_aplBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [_aplBtn autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_aplBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    
    [self.contentView addSubview:self.youtubeBtn];
    [_youtubeBtn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0];
    [_youtubeBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15.0];
    [_youtubeBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    
    
    [self.contentView addSubview:self.soundcloudBtn];
    [_soundcloudBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    [_soundcloudBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_spotifyBtn];
    [_soundcloudBtn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:(icon_dim*.75)];


    [self.contentView addSubview:self.tidalBtn];
    [_tidalBtn autoSetDimensionsToSize:CGSizeMake(icon_dim, icon_dim)];
    [_tidalBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_youtubeBtn];
    [_tidalBtn autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:(icon_dim*.75)];
 }

- (UIButton *)spotifyBtn {
    if (!_spotifyBtn) {
        _spotifyBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"spotify"];
        [_spotifyBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        [self.spotifyBtn addTarget:self action:@selector(openSpotify:) forControlEvents:UIControlEventTouchUpInside];
    }
    _spotifyBtn.userInteractionEnabled = YES;
    return _spotifyBtn;
}

- (UIButton *)tidalBtn {
    if (!_tidalBtn) {
        _tidalBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"tidal"];
        [_tidalBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _tidalBtn.frame = CGRectMake(200, 25, 150, 75);
        [self.tidalBtn addTarget:self action:@selector(openTidal:) forControlEvents:UIControlEventTouchUpInside];
    }
    _tidalBtn.userInteractionEnabled = YES;
    return _tidalBtn;
}

- (UIButton *)aplBtn {
    if (!_aplBtn) {
        _aplBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"applemusic"];
        [_aplBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _aplBtn.frame = CGRectMake(10, 150, 150, 75);
        [self.aplBtn addTarget:self action:@selector(openApl:) forControlEvents:UIControlEventTouchUpInside];
    }
    _aplBtn.userInteractionEnabled = YES;
    return _aplBtn;
}

- (UIButton *)soundcloudBtn {
    if (!_soundcloudBtn) {
        _soundcloudBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"soundcloud"];
        [_soundcloudBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _soundcloudBtn.frame = CGRectMake(200, 150, 150, 75);
        [self.soundcloudBtn addTarget:self action:@selector(openSoundcloud:) forControlEvents:UIControlEventTouchUpInside];
    }
    _soundcloudBtn.userInteractionEnabled = YES;
    return _soundcloudBtn;
}

- (UIButton *)youtubeBtn {
    if (!_youtubeBtn) {
        _youtubeBtn = [[UIButton alloc] initForAutoLayout];
        UIImage *btnImage = [UIImage imageNamed:@"youtube"];
        [_youtubeBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
        _youtubeBtn.frame = CGRectMake(10, 225, 150, 75);
        [self.youtubeBtn addTarget:self action:@selector(openYoutube:) forControlEvents:UIControlEventTouchUpInside];
    }
    _youtubeBtn.userInteractionEnabled = YES;
    return _youtubeBtn;
}


- (void)configureCellWithArtist:(DILPFArtist *)artist{
    self.spotifyUrl = [@"http://open.spotify.com/artist/" stringByAppendingString:artist.spotifyUrl];
    self.tidalUrl = [@"http://tidal.com/artist/" stringByAppendingString:artist.tidalUrl];
    self.aplUrl = [@"https://itun.es/us/" stringByAppendingString:artist.aplUrl]; // opens safari
    self.soundcloudUrl = [@"https://soundcloud.com/" stringByAppendingString:artist.soundcloudUrl];
    self.youtubeUrl = [@"https://www.youtube.com/user/" stringByAppendingString:artist.youtubeUrl];
}

- (void)openSpotify:(id)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.spotifyUrl]];
}

- (void)openTidal:(id)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.tidalUrl]];
}

- (void)openApl:(id)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.aplUrl]];
}

- (void)openSoundcloud:(id)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.soundcloudUrl]];
}

- (void)openYoutube:(id)sender {
    [[UIApplication sharedApplication] openURL:
     [NSURL URLWithString: self.youtubeUrl]];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}
@end
