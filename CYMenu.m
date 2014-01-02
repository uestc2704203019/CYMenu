//
//  CYMenu.m
//  loveLife
//
//  Created by chai yuan on 13-12-31.
//  Copyright (c) 2013年 chai yuan. All rights reserved.
//

#import "CYMenu.h"

@implementation CYMenu
@synthesize delegate = _delegate;
@synthesize datasource = _datasource;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

/*
 *
 *
 *所有需要初始化的信息初始化
 *
 */
- (void)initialize
{
    isNeedReload = YES;
    items = [[NSMutableSet alloc] init];
    itemnumber = 0;
    rownumber = CYMENUTHREE;
    item_squre = 90.0f;
    item_interval = 10.0f;
    
    baseScroll = [[UIScrollView alloc] init];
}

- (void)itemSqure
{
    switch (rownumber) {
        case CYMENUONE:;
        {
            item_squre = 240.0f;
            item_interval = 40.0f;
            
            if (_datasource && [_datasource respondsToSelector:@selector(itemSqureForMenuItem:)]) {
                item_squre = [_datasource itemSqureForMenuItem:self];
            }
            if (_datasource && [_datasource respondsToSelector:@selector(itemIntervalForMenuItem:)]) {
                item_interval = [_datasource itemIntervalForMenuItem:self];
            }
        }
            break;
        case CYMENUTWO:;
        {
            item_squre = 130.0f;
            item_interval = 20.0f;
            
            if (_datasource && [_datasource respondsToSelector:@selector(itemSqureForMenuItem:)]) {
                item_squre = [_datasource itemSqureForMenuItem:self];
            }
            if (_datasource && [_datasource respondsToSelector:@selector(itemIntervalForMenuItem:)]) {
                item_interval = [_datasource itemIntervalForMenuItem:self];
            }
        }
            break;
        case CYMENUTHREE:;
        {
            item_squre = 90.0f;
            item_interval = 10.0f;

            if (_datasource && [_datasource respondsToSelector:@selector(itemSqureForMenuItem:)]) {
                item_squre = [_datasource itemSqureForMenuItem:self];
            }
            if (_datasource && [_datasource respondsToSelector:@selector(itemIntervalForMenuItem:)]) {
                item_interval = [_datasource itemIntervalForMenuItem:self];
            }
        }
            break;
        case CYMENUFOUR:;
        {
            item_squre = 70.0f;
            item_interval = 8.0f;
            
            if (_datasource && [_datasource respondsToSelector:@selector(itemSqureForMenuItem:)]) {
                item_squre = [_datasource itemSqureForMenuItem:self];
            }
            if (_datasource && [_datasource respondsToSelector:@selector(itemIntervalForMenuItem:)]) {
                item_interval = [_datasource itemIntervalForMenuItem:self];
            }
        }
            break;
        default:
            break;
    }
}

- (void)reloadData
{
    isNeedReload = YES;
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (isNeedReload) {
        if (_datasource && [_datasource respondsToSelector:@selector(numberForMemuItems:)]) {
            itemnumber = [_datasource numberForMemuItems:self];
        }
        if (_datasource && [_datasource respondsToSelector:@selector(numberForMenuItemsInOneRow:)]) {
            rownumber = [_datasource numberForMenuItemsInOneRow:self];
        }
        [self itemSqure];
        
        NSInteger sectionnumber = ceil(itemnumber/rownumber);
        
        if (!baseScroll) {
            baseScroll = [[UIScrollView alloc] init];
        }
        baseScroll.frame = self.bounds;
        baseScroll.contentSize = CGSizeMake(self.bounds.size.width, item_squre*sectionnumber+item_interval*(sectionnumber+1));
        [self addSubview:baseScroll];
        
        for (int i=0; i<itemnumber; i++) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureMethod:)];
            [tapGesture setNumberOfTapsRequired:1];

            CYMenuItem *menuitem = [self viewAtIndex:i containerView:self];
            menuitem.frame = CGRectMake((i%rownumber)*item_squre+(i%rownumber+1)*item_interval, (i/rownumber)*item_squre+(i/rownumber+1)*item_interval, item_squre, item_squre);
            if (!menuitem.superview) {
                menuitem.sort = i;
                [baseScroll addSubview:menuitem];
                [menuitem addGestureRecognizer:tapGesture];
            }
            tapGesture = nil;
            menuitem = nil;
        }
    }
}

- (void)tapGestureMethod:(id)object
{
    NSInteger sort = [(CYMenuItem *)[object view] sort];
    if (_delegate && [_delegate respondsToSelector:@selector(menuDidSelectItem:)]) {
        [_delegate menuDidSelectItem:sort];
    }
}

- (CYMenuItem *)viewAtIndex:(NSInteger)index containerView:(CYMenu *)menu
{
    return [_datasource itemForMenu:self];
}

- (void)dequeueView:(CYMenuItem *)view
{
    if (view) {
        [items addObject:view];
    }
}

- (CYMenuItem *)dequeueIndierfier
{
    CYMenuItem *view = (CYMenuItem *)[items anyObject];
    if (view) {
        [items removeObject:view];
    }
    return view;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
