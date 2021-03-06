//
//  CachedTableViewCell.m
//  NSCacheSample
//
// Copyright 2011 by Michal Tuszynski
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


#import "CachedTableViewCell.h"
#import "CacheController.h"

@implementation CachedTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}


-(void)downloadFile:(NSURL *)fileUrl forIndexPath:(NSIndexPath *)indexPath {
    
    [[self textLabel] setText:@"Downloading file..."];
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(dispatchQueue, ^ {
       
        NSData *fileData = [NSData dataWithContentsOfURL:fileUrl];
        NSString *cacheKey = [NSString stringWithFormat:@"Cache%d%d", indexPath.row, indexPath.section];
        
        [[CacheController sharedInstance] setCache:fileData forKey:cacheKey];
        
        dispatch_async(dispatch_get_main_queue(), ^ {
           
            [[self textLabel] setText:@"Finished downloading file!"];
            
        });
        
    });
}

@end
