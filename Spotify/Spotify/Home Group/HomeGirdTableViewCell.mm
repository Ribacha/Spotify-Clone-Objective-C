//
//  HomeGirdTableViewCell.m
//  Spotify
//
//  Created by 开开心心的macbook air on 2025/11/27.
//

#import "HomeGirdTableViewCell.h"
#import "MusicCardCollectionView.h"
#import "Masonry/Masonry.h"
@implementation HomeGirdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupCollectionView];
  }
  return self;
}
- (void) setupCollectionView {
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  layout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 16 * 2 - 8) / 2, 56);
  layout.minimumLineSpacing = 8;
  layout.minimumInteritemSpacing = 8;
  layout.sectionInset = UIEdgeInsetsMake(8, 16, 8, 16);
  self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
  self.collectionView.backgroundColor = [UIColor clearColor];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  self.collectionView.scrollEnabled = NO;
  [self.collectionView registerClass:[MusicCardCollectionView class] forCellWithReuseIdentifier:@"MusicCardCell"];
  [self.contentView addSubview:self.collectionView];
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.contentView);
  }];
}
- (void)setGirdModels:(NSArray<SpotifyModels *> *)girdModels{
  _girdModels = girdModels;
  [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  if (self.girdModels.count > 0) {
    return MIN(self.girdModels.count, 6);
  }
  return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MusicCardCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MusicCardCell" forIndexPath:indexPath];
  [cell configureWithModel:self.girdModels[indexPath.item]];
  return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  SpotifyModels *models = self.girdModels[indexPath.item];
  if (self.pushBlock) {
    self.pushBlock(models);
  }
}
@end
