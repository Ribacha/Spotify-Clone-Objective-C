//
//  AlbumTableViewCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/19.
//

#import "AlbumTableViewCell.h"
#import "AlbumCollectionViewCell.h"
#import "Masonry/Masonry.h"
@implementation AlbumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
  
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor blackColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupUI];
  }
  return self;
}
// AlbumTableViewCell.m

- (void)setupUI {
    if (!self.headerLabel) {
        self.headerLabel = [[UILabel alloc] init];
        self.headerLabel.font = [UIFont systemFontOfSize:33 weight:UIFontWeightBold];
        self.headerLabel.textColor = [UIColor whiteColor];
        self.headerLabel.textAlignment = NSTextAlignmentLeft;
    }
    [self.contentView addSubview:self.headerLabel];
    [self.headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(30); 
    }];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(120, 160);
    layout.minimumLineSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.colletionView.backgroundColor = [UIColor clearColor];
    self.colletionView.dataSource = self;
    self.colletionView.delegate = self;
    self.colletionView.showsHorizontalScrollIndicator = NO;
    [self.colletionView registerClass:[AlbumCollectionViewCell class] forCellWithReuseIdentifier:@"AlbumCell"];
    [self.contentView addSubview:self.colletionView];
    [self.colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.headerLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}
- (void)configureWithTitle:(NSString *)title albums:(NSArray<SpotifyModels *> *)albums {
    self.headerLabel.text = title;
    self.albums = albums;
    [self.colletionView reloadData];
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  AlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AlbumCell" forIndexPath:indexPath];
  SpotifyModels *album = self.albums[indexPath.item];
  [cell configureWithAlbum:album];
  return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 6;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  SpotifyModels *models = self.albums[indexPath.item];
  if (self.pushBlock) {
    self.pushBlock(models);
  }
}
@end
