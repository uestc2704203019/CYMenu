//
//  CYMenu.h
//  loveLife
//
//  Created by chai yuan on 13-12-31.
//  Copyright (c) 2013年 chai yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYMenuItem.h"

typedef enum {
    CYMENUONE = 1,
    CYMENUTWO = 2,
    CYMENUTHREE = 3,
    CYMENUFOUR = 4,
}CYMENUNUMBER;

@class CYMenu;

@protocol CYMenuDataSource <NSObject>

- (NSInteger)numberForMemuItems:(CYMenu *)menu;
- (CYMenuItem *)itemForMenu:(CYMenu *)menu;

@optional

- (CYMENUNUMBER)numberForMenuItemsInOneRow:(CYMenu *)menu;
- (CGSize)sizeForMenu:(CYMenu *)menu;
- (CGFloat)itemSqureForMenuItem:(CYMenu *)menu;
- (CGFloat)itemIntervalForMenuItem:(CYMenu *)menu;

@end

@protocol CYMenuDelegate <NSObject>

@optional
- (void)menuDidSelectItem:(NSInteger)menuIndex;

@end

@interface CYMenu : UIView
{
    NSInteger itemnumber;
    NSInteger rownumber;
    
    float item_squre;
    float item_interval;
    
    BOOL isNeedReload;
    
    NSMutableSet *items;
    
    CGSize contentSize;
    
    UIScrollView *baseScroll;
}

@property (nonatomic, assign) id <CYMenuDataSource> datasource;
@property (nonatomic, assign) id <CYMenuDelegate> delegate;

- (void)reloadData;
- (CYMenuItem *)dequeueIndierfier;

@end
