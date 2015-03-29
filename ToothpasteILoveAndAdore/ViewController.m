//
//  ViewController.m
//  ToothpasteILoveAndAdore
//
//  Created by Rockstar. on 3/26/15.
//  Copyright (c) 2015 Fantastik. All rights reserved.
//

#import "ViewController.h"
#import "ToothpastesTableViewController.h"

#define kNSUUserDefaultsLastSavedKey @"kNSUUserDefaultsLastSavedKey"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *adoredToothpaste;
@property (weak, nonatomic) IBOutlet UITableView *adoredTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self load];
    if (!self.adoredToothpaste) {
        self.adoredToothpaste = [NSMutableArray new];
    }
    // Do any additional setup after loading the view, typically from a nib.
}



- (NSURL *)documentDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
}

- (void)load {
    NSURL *plist = [[self documentDirectory] URLByAppendingPathComponent:@"Paste.plist"];
    self.adoredToothpaste = [NSMutableArray arrayWithContentsOfURL:plist];
}

- (void)save {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSDate date] forKey:kNSUUserDefaultsLastSavedKey];
    [userDefaults synchronize];

    NSURL *plist = [[self documentDirectory] URLByAppendingPathComponent:@"Paste.plist"];
    [self.adoredToothpaste writeToURL:plist atomically:YES];
}

- (IBAction)unwind:(UIStoryboardSegue *)segue {
    ToothpastesTableViewController *vc = segue.sourceViewController;
    NSIndexPath *indexPath;

    [self.adoredToothpaste addObject:[vc addoredToothpaste]];
    indexPath = [NSIndexPath indexPathForRow:self.adoredToothpaste.count - 1 inSection:0];
    [self.adoredTableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self save];

}

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.adoredToothpaste.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = self.adoredToothpaste[indexPath.row];
    return cell;
}

@end
