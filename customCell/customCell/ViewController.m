//
//  ViewController.m
//  customCell
//
//  Created by Jullia Sharaeva on 14.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

@interface ViewController ()

@end

@implementation ViewController
{
     UITableView *tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // init table view
    tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor cyanColor];
    // add to canvas
    [self.view addSubview:tableView];
}
#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell…
    switch (indexPath.row) {
        case 0:
            cell.primaryLabel.text = @"Meeting on iPhone Development";
            cell.secondaryLabel.text = @"Sat 10:30";
            cell.myImageView.image = [UIImage imageNamed:@"meeting_color.png"];
            break;
        case 1:
            cell.primaryLabel.text = @"Call With Client";
            cell.secondaryLabel.text = @"Planned";
            cell.myImageView.image = [UIImage imageNamed:@"call_color.png"];
            break;
        case 2:
            cell.primaryLabel.text = @"Appointment with Joey";
            cell.secondaryLabel.text = @"2 Hours";
            cell.myImageView.image = [UIImage imageNamed:@"calendar_color.png"];
            break;
        case 3:
            cell.primaryLabel.text = @"Call With Client";
            cell.secondaryLabel.text = @"Planned";
            cell.myImageView.image = [UIImage imageNamed:@"call_color.png"];
            break;
        case 4:
            cell.primaryLabel.text = @"Appointment with Joey";
            cell.secondaryLabel.text = @"2 Hours";
            cell.myImageView.image = [UIImage imageNamed:@"calendar_color.png"];
            break;
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
@end;
